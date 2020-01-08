package main

import "io/ioutil"

func main() {
	rom := make([]byte, 32768) // 2^15 == 32768

	// initialise slice to be 0xea for each byte
	for i := 0; i < 32768; i++ {
		rom[i] = 0xea
	}

	rom[0x7ffc] = 0x00
	rom[0x7ffd] = 0x80

	err := ioutil.WriteFile("rom.bin", rom, 0644)

	if err != nil {
		panic(err)
	}
}
