// Binary snip generates snippets.
package main

import (
	"bytes"
	"flag"
	"fmt"
	"log"
	"os"
	"path/filepath"
	"strings"
	"text/template"
)

type pairs map[string]string

func (ps pairs) String() string {
	return ""
}

func (ps pairs) Set(s string) error {
	k, v, ok := strings.Cut(s, "=")
	if !ok {
		return fmt.Errorf("got %q, want key=val", s)
	}
	ps[k] = v
	return nil
}

const usage = `Add a snippet.

USAGE
  snip [-h] [-l] [[-o] -w] [-t key=val] <name>

FLAGS
  -h           Show this help document
  -l           List snippets
  -o           Output filename if -w
  -t key=val   Template variable
  -w           Write to file`

func main() {
	log.SetFlags(0)
	log.SetPrefix("snip: ")

	var (
		list   = flag.Bool("l", false, "")
		output = flag.String("o", "", "")
		write  = flag.Bool("w", false, "")
	)

	args := make(pairs)
	flag.Var(args, "t", "")

	flag.Usage = func() {
		if _, err := fmt.Fprintln(os.Stderr, usage); err != nil {
			log.Fatalln(err)
		}
	}
	flag.Parse()

	dir, err := os.UserConfigDir()
	if err != nil {
		log.Fatalln(err)
	}

	cfg := filepath.Join(dir, "snip")

	if err := os.MkdirAll(cfg, 0o755); err != nil {
		log.Fatalln(err)
	}

	if *list {
		es, err := os.ReadDir(cfg)
		if err != nil {
			log.Fatalln(err)
		}

		for _, e := range es {
			fmt.Println(e.Name())
		}
		return
	}

	if flag.NArg() == 0 {
		flag.Usage()
		os.Exit(64)
	}

	name := flag.Arg(0)

	data, err := os.ReadFile(filepath.Join(cfg, name))
	if err != nil {
		log.Fatalln(err)
	}

	tmpl := template.Must(template.New(name).Parse(string(data)))

	var buf bytes.Buffer
	if err := tmpl.Execute(&buf, map[string]string(args)); err != nil {
		log.Fatalln(err)
	}

	data = buf.Bytes()

	if *write {
		if path := *output; len(path) != 0 {
			name = path
		}

		if err = os.WriteFile(name, data, 0o644); err != nil {
			log.Fatalln(err)
		}
		return
	}

	if _, err = os.Stdout.Write(data); err != nil {
		log.Fatalln(err)
	}
}
