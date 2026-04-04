// Binary apple_remap remaps the following keys on macOS:
//
//	Right Alt -> Right Ctrl
//	Esc       -> Caps Lock
//	Caps Lock -> Esc
//
// See https://tshaka.dev/a/JB3J7X.
package main

import (
	"log"
	"os"
	"os/exec"
)

const m = `
{
  "UserKeyMapping": [
    {
      "HIDKeyboardModifierMappingSrc": 0x7000000e6,
      "HIDKeyboardModifierMappingDst": 0x7000000e4,
    },
    {
      "HIDKeyboardModifierMappingSrc": 0x700000029,
      "HIDKeyboardModifierMappingDst": 0x700000039,
    },
    {
      "HIDKeyboardModifierMappingSrc": 0x700000039,
      "HIDKeyboardModifierMappingDst": 0x700000029,
    },
  ]
}
`

func main() {
	log.SetFlags(0)
	log.SetPrefix("apple_remap: ")

	c := exec.Command("hidutil", "property", "--set", m)
	c.Stderr = os.Stderr

	if err := c.Run(); err != nil {
		log.Fatal(err)
	}
}
