upload:
	arduino --upload --board arduino:avr:mega:cpu=atmega2560 --port /dev/ttyACM0 --pref programmer=arduino:usbtinyisp --pref build.path=/home/kurt/personal/my-6502-computer/6502-analysis/build --verbose-upload /home/kurt/personal/my-6502-computer/6502-analysis/6502-analysis.ino

serial:
	screen /dev/ttyACM0 57600

.PHONY: test clean all
