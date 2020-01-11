a.out: lcd_experimental.s
	vasm6502_oldstyle -Fbin -dotdir lcd_experimental.s

program: a.out
	sudo minipro -p AT28C256 -w a.out

dump: a.out
	hexdump -C a.out
