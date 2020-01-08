package main

import "io/ioutil"

func main() {
	rom := make([]byte, 32768) // 2^15 == 32768

	// initialise slice to be 0xea for each byte
	for i := 0; i < 32768; i++ {
		rom[i] = 0xea
	}

	// 6502 reads the program start location from 0xfffc and 0xfffd, I have
	// hooked A16 of the 6502 to chip enable on the ROM so that's my it's
	// inserted into the rom at 0x7ffc and 0x7ffd
	// so the program start address of 0x8000 will correspond to 0x0000 in
	// the ROM
	rom[0x7ffc] = 0x00
	rom[0x7ffd] = 0x80

	// lda 0x42
	rom[0] = 0xa9
	rom[1] = 0x42

	// sta 0x6000
	rom[2] = 0x8d
	rom[3] = 0x00
	rom[4] = 0x60

	err := ioutil.WriteFile("rom.bin", rom, 0644)

	if err != nil {
		panic(err)
	}
}
