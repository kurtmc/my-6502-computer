rom.bin: main.go
	go run main.go

program: rom.bin
	sudo minipro -p AT28C256 -w rom.bin
