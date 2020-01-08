package main

import "io/ioutil"

func main() {
	rom := make([]byte, 32768) // 2^15 == 32768

	// initialise slice to be 0xea for each byte
	for i := 0; i < 32768; i++ {
		rom[i] = 0xea
	}

	err := ioutil.WriteFile("rom.bin", rom, 0644)

	if err != nil {
		panic(err)
	}
}
