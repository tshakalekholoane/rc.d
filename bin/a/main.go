package main

import (
	"bytes"
	"flag"
	"fmt"
	"io"
	"log"
	"net/http"
	"os"
	"path/filepath"
	"strings"
	"unicode"
)

const usage = `Shorten a URL.

USAGE
  a [-h] <URL>

FLAGS
  -h   Show this help document`

func main() {
	log.SetFlags(0)
	log.SetPrefix("snip: ")

	flag.Usage = func() {
		if _, err := fmt.Fprintln(os.Stderr, usage); err != nil {
			log.Fatalln(err)
		}
	}
	flag.Parse()

	if flag.NArg() == 0 {
		flag.Usage()
		os.Exit(64)
	}

	dir, err := os.UserConfigDir()
	if err != nil {
		log.Fatalln(err)
	}

	data, err := os.ReadFile(filepath.Join(dir, "a", "config"))
	if err != nil {
		log.Fatalln(err)
	}

	user, pass, ok := bytes.Cut(bytes.TrimRightFunc(data, unicode.IsSpace), []byte(":"))
	if !ok {
		log.Fatalln("invalid credential file")
	}

	req, err := http.NewRequest(
		http.MethodPost,
		"https://tshaka.dev/a/",
		strings.NewReader(flag.Arg(0)),
	)
	if err != nil {
		log.Fatalln(err)
	}
	req.SetBasicAuth(string(user), string(pass))

	c := &http.Client{}
	resp, err := c.Do(req)
	if err != nil {
		log.Fatalln(err)
	}
	defer resp.Body.Close()

	if _, err = io.Copy(os.Stdout, resp.Body); err != nil {
		log.Fatalln(err)
	}
}
