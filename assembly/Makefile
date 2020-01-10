a.out: blink.s
	vasm6502_oldstyle -Fbin -dotdir blink.s

program: a.out
	sudo minipro -p AT28C256 -w a.out

dump: a.out
	hexdump -C a.out
