// / Package search provides site search in the terminal.
package main

import (
	"encoding/csv"
	"errors"
	"flag"
	"fmt"
	"io/fs"
	"log"
	"maps"
	"net/url"
	"os"
	"os/exec"
	"path/filepath"
	"runtime"
	"slices"
	"strings"
	"text/tabwriter"
)

func config() (string, error) {
	d, err := os.UserConfigDir()
	if err != nil {
		return "", err
	}
	return filepath.Join(d, "search", "config"), nil
}

func load(conf string) (map[string]string, error) {
	f, err := os.Open(conf)
	if err != nil {
		if errors.Is(err, fs.ErrNotExist) {
			return make(map[string]string), nil
		}
		return nil, err
	}
	defer f.Close()

	r := csv.NewReader(f)
	r.Comment = '#'
	r.FieldsPerRecord = 2
	r.ReuseRecord = true
	r.TrimLeadingSpace = true

	records, err := r.ReadAll()
	if err != nil {
		return nil, err
	}

	searches := make(map[string]string, len(records))
	for _, rec := range records {
		if len(rec) != 2 {
			return nil, fmt.Errorf("invalid number of fields %d, want 2", len(rec))
		}

		k, q := strings.TrimSpace(rec[0]), strings.TrimSpace(rec[1])
		if len(k) == 0 || len(q) == 0 {
			return nil, errors.New("record with empty column entry")
		}
		searches[k] = q
	}
	return searches, nil
}

func open(u string) error {
	v, err := url.Parse(u)
	if err != nil {
		return err
	}

	// open on macOS does not work with well with file:// URLs that
	// contain queries.
	if v.Scheme != "http" && v.Scheme != "https" {
		return fmt.Errorf("URL scheme must be http(s) not %q", v.Scheme)
	}

	var name string
	switch runtime.GOOS {
	case "darwin":
		name = "open"
	case "linux":
		name = "xdg-open"
	default:
		return errors.New("unsupported operating system")
	}

	c := exec.Command(name, u)
	c.Stderr = os.Stderr
	return c.Run()
}

func add(k, t string) error {
	if !strings.Contains(t, "%s") {
		return fmt.Errorf("template %q must contain %%", t)
	}

	p, err := config()
	if err != nil {
		return err
	}

	if err = os.MkdirAll(filepath.Dir(p), 0o755); err != nil {
		return err
	}

	if _, err = os.Stat(p); err == nil {
		searches, err := load(p)
		if err != nil {
			return err
		}
		if _, ok := searches[k]; ok {
			return fmt.Errorf("shortcut %q already exists; edit %s to change it", k, p)
		}
	}

	f, err := os.OpenFile(p, os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0o644)
	if err != nil {
		return err
	}
	defer f.Close()

	w := csv.NewWriter(f)
	if err = w.Write([]string{k, t}); err != nil {
		return err
	}
	w.Flush()
	if err = w.Error(); err != nil {
		return err
	}
	return nil
}

func list() error {
	p, err := config()
	if err != nil {
		return err
	}

	searches, err := load(p)
	if err != nil {
		return err
	}

	if len(searches) == 0 {
		return nil
	}

	w := tabwriter.NewWriter(os.Stdout, 0, 0, 2, ' ', 0)
	for _, k := range slices.Sorted(maps.Keys(searches)) {
		if _, err = fmt.Fprintf(w, "%s\t%s\n", k, searches[k]); err != nil {
			return err
		}
	}

	return w.Flush()
}

func search(k, q string) error {
	p, err := config()
	if err != nil {
		return err
	}

	searches, err := load(p)
	if err != nil {
		return err
	}

	t, ok := searches[k]
	if !ok {
		return fmt.Errorf("unknown shortcut %q, use `list` to see available shortcuts", k)
	}

	return open(strings.ReplaceAll(t, "%s", url.QueryEscape(q)))
}

func main() {
	flag.Usage = func() {
		fmt.Fprintf(os.Stderr, `search — search shortcuts

USAGE
  search <key> <query>         Open URL for shortcut <key> with <query>
  search add <key> <template>  Add a new shortcut (template must contain %%s)
  search list                  List all shortcuts
  search help                  Show this help document

EXAMPLES
  search add g https://www.google.com/search?q=%%s
  search g "What is the weather like today?"
`)
	}

	flag.Parse()

	log.SetFlags(0)
	log.SetPrefix("search: ")

	if flag.NArg() == 0 {
		flag.Usage()
		os.Exit(64)
	}

	switch flag.Arg(0) {
	case "-h", "--help", "help":
		flag.Usage()
	case "add":
		if flag.NArg() < 3 {
			flag.Usage()
			os.Exit(64)
		}
		if err := add(flag.Arg(1), flag.Arg(2)); err != nil {
			log.Fatalln(err)
		}
	case "list":
		if flag.NArg() != 1 {
			flag.Usage()
			os.Exit(64)
		}
		if err := list(); err != nil {
			log.Fatalln(err)
		}
	default:
		if flag.NArg() < 2 {
			flag.Usage()
			os.Exit(64)
		}
		if err := search(flag.Arg(0), strings.Join(flag.Args()[1:], " ")); err != nil {
			log.Fatalln(err)
		}
	}
}
