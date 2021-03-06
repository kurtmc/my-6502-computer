PORTB = $6000 ; port B on 6522
PORTA = $6001 ; port A on 6522
DDRB = $6002 ; data direction register for port B
DDRA = $6003 ; data direction register for port A

E  = %10000000
RW = %01000000
RS = %00100000

  .org $8000

reset:
  lda #%11111111 ; Set all pins on port B to output
  sta DDRB

  lda #%11100000 ; Set top 3 pins on port A to output
  sta DDRA


; setup display
  lda #%00111000 ; Set 8-bit mode; 2-line display; 5x8 font
  sta PORTB

  lda #0 ; Clear RS/RW/E bits
  sta PORTA

  lda #E ; set E bit to enable instruction
  sta PORTA

  lda #0 ; Clear RS/RW/E bits
  sta PORTA


; turn on display
  lda #%00001110 ; Display on, cursor on; blink off
  sta PORTB

  lda #0 ; Clear RS/RW/E bits
  sta PORTA

  lda #E ; set E bit to enable instruction
  sta PORTA

  lda #0 ; Clear RS/RW/E bits
  sta PORTA

; Entry mode set
  lda #%00000110 ; Increment and shift cursor; dont' shift display
  sta PORTB

  lda #0 ; Clear RS/RW/E bits
  sta PORTA

  lda #E ; set E bit to enable instruction
  sta PORTA

  lda #0 ; Clear RS/RW/E bits
  sta PORTA

; Clear display
  lda #%00000001
  sta PORTB
  lda #0 ; Clear RS/RW/E bits
  sta PORTA
  lda #E ; set E bit to enable instruction
  sta PORTA
  lda #0 ; Clear RS/RW/E bits
  sta PORTA

; Return home
  lda #%00000010 ; Return home
  sta PORTB
  lda #0 ; Clear RS/RW/E bits
  sta PORTA
  lda #E ; set E bit to enable instruction
  sta PORTA
  lda #0 ; Clear RS/RW/E bits
  sta PORTA

; Write "H"
  lda #"H"
  sta PORTB
  lda #RS ; Set RS; Clear RW/E bits
  sta PORTA
  lda #(RS | E) ; set E bit to enable instruction
  sta PORTA
  lda #RS ; Set RS; Clear RW/E bits
  sta PORTA

; Write "e"
  lda #"e"
  sta PORTB
  lda #RS ; Set RS; Clear RW/E bits
  sta PORTA
  lda #(RS | E) ; set E bit to enable instruction
  sta PORTA
  lda #RS ; Set RS; Clear RW/E bits
  sta PORTA

; Write "l"
  lda #"l"
  sta PORTB
  lda #RS ; Set RS; Clear RW/E bits
  sta PORTA
  lda #(RS | E) ; set E bit to enable instruction
  sta PORTA
  lda #RS ; Set RS; Clear RW/E bits
  sta PORTA

; Write "l"
  lda #"l"
  sta PORTB
  lda #RS ; Set RS; Clear RW/E bits
  sta PORTA
  lda #(RS | E) ; set E bit to enable instruction
  sta PORTA
  lda #RS ; Set RS; Clear RW/E bits
  sta PORTA

; Write "o"
  lda #"o"
  sta PORTB
  lda #RS ; Set RS; Clear RW/E bits
  sta PORTA
  lda #(RS | E) ; set E bit to enable instruction
  sta PORTA
  lda #RS ; Set RS; Clear RW/E bits
  sta PORTA

; Write ","
  lda #","
  sta PORTB
  lda #RS ; Set RS; Clear RW/E bits
  sta PORTA
  lda #(RS | E) ; set E bit to enable instruction
  sta PORTA
  lda #RS ; Set RS; Clear RW/E bits
  sta PORTA

; Write " "
  lda #" "
  sta PORTB
  lda #RS ; Set RS; Clear RW/E bits
  sta PORTA
  lda #(RS | E) ; set E bit to enable instruction
  sta PORTA
  lda #RS ; Set RS; Clear RW/E bits
  sta PORTA

; Write "W"
  lda #"W"
  sta PORTB
  lda #RS ; Set RS; Clear RW/E bits
  sta PORTA
  lda #(RS | E) ; set E bit to enable instruction
  sta PORTA
  lda #RS ; Set RS; Clear RW/E bits
  sta PORTA

; Write "o"
  lda #"o"
  sta PORTB
  lda #RS ; Set RS; Clear RW/E bits
  sta PORTA
  lda #(RS | E) ; set E bit to enable instruction
  sta PORTA
  lda #RS ; Set RS; Clear RW/E bits
  sta PORTA

; Write "r"
  lda #"r"
  sta PORTB
  lda #RS ; Set RS; Clear RW/E bits
  sta PORTA
  lda #(RS | E) ; set E bit to enable instruction
  sta PORTA
  lda #RS ; Set RS; Clear RW/E bits
  sta PORTA

; Write "l"
  lda #"l"
  sta PORTB
  lda #RS ; Set RS; Clear RW/E bits
  sta PORTA
  lda #(RS | E) ; set E bit to enable instruction
  sta PORTA
  lda #RS ; Set RS; Clear RW/E bits
  sta PORTA

; Write "d"
  lda #"d"
  sta PORTB
  lda #RS ; Set RS; Clear RW/E bits
  sta PORTA
  lda #(RS | E) ; set E bit to enable instruction
  sta PORTA
  lda #RS ; Set RS; Clear RW/E bits
  sta PORTA

; Write "!"
  lda #"!"
  sta PORTB
  lda #RS ; Set RS; Clear RW/E bits
  sta PORTA
  lda #(RS | E) ; set E bit to enable instruction
  sta PORTA
  lda #RS ; Set RS; Clear RW/E bits
  sta PORTA

loop:
  jmp loop

  .org $fffc
  .word reset
  .word $0000
