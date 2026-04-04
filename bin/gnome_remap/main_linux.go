// Binary gnome_remap swaps the caps lock and escape keys in GNOME.
package main

import (
	"log"
	"os"
	"os/exec"
)

func main() {
	log.SetFlags(0)
	log.SetPrefix("gnome_remap: ")

	c := exec.Command(
		"gsettings",
		"set",
		"org.gnome.desktop.input-sources",
		"xkb-options",
		"['caps:swapescape']",
	)
	c.Stdout = os.Stdout
	c.Stderr = os.Stderr
	if err := c.Run(); err != nil {
		log.Fatal(err)
	}
}
