TMP_A = $0000
TMP_X = $0001
PORTB = $6000 ; port B on 6522
PORTA = $6001 ; port A on 6522
DDRB = $6002 ; data direction register for port B
DDRA = $6003 ; data direction register for port A

E  = %10000000
RW = %01000000
RS = %00100000

  .org $8000

  jmp main

line_1:
  .string "rm -rf /*"
line_2:
  .string "shutting down.."

wait_not_busy:
  sta TMP_A ; temporarily store register A
  stx TMP_X ; temporarily store register X

  ; make port B input
  lda #%00000000
  sta DDRB

_wait_not_busy_loop:
  lda #0 ; Clear RS/RW/E bits
  sta PORTA

  lda #(RW | E) ; Set E and RW
  sta PORTA

  ldx PORTB

  lda #0 ; Clear RS/RW/E bits
  sta PORTA

  cmp #%10000000 ; busy bit is highest bit
  bcs _wait_not_busy_loop

  ; make port B output
  lda #%11111111
  sta DDRB

  lda TMP_A ; return register A
  ldx TMP_X ; return register X
  rts

lcd_send_cmd:
  jsr wait_not_busy
  sta PORTB
  lda #0 ; Clear RS/RW/E bits
  sta PORTA
  lda #E ; set E bit to enable instruction
  sta PORTA
  lda #0 ; Clear RS/RW/E bits
  sta PORTA
  rts

write_character:
  sta PORTB
  lda #RS ; Set RS; Clear RW/E bits
  sta PORTA
  lda #(RS | E) ; set E bit to enable instruction
  sta PORTA
  lda #RS ; Set RS; Clear RW/E bits
  sta PORTA
  rts

main:
  lda #%11111111 ; Set all pins on port B to output
  sta DDRB

  lda #%11100000 ; Set top 3 pins on port A to output
  sta DDRA

; setup display
  lda #%00111000 ; Set 8-bit mode; 2-line display; 5x8 font
  jsr lcd_send_cmd

; turn on display
  lda #%00001110 ; Display on, cursor on; blink off
  jsr lcd_send_cmd

; Entry mode set
  lda #%00000110 ; Increment and shift cursor; dont' shift display
  jsr lcd_send_cmd

; Clear display
  lda #%00000001
  jsr lcd_send_cmd

; Return home
  lda #%00000010 ; Return home
  jsr lcd_send_cmd

; print line_1
  ldx #0    ; Start with the first byte
_loop1:
  lda line_1,x ; load a byte from SRC into the A register
  jsr write_character
  inx       ; bump the index register to point to the next SRC and DST locations
  lda line_1,x ; load a byte from SRC into the A register
  cmp #0    ; is this the zero byte?
  bne _loop1 ; if not, go move the next one

; Go to line 2
  lda #%10101000
  jsr lcd_send_cmd

; print line_2
  ldx #0    ; Start with the first byte
_loop2:
  lda line_2,x ; load a byte from SRC into the A register
  jsr write_character
  inx       ; bump the index register to point to the next SRC and DST locations
  lda line_2,x ; load a byte from SRC into the A register
  cmp #0    ; is this the zero byte?
  bne _loop2 ; if not, go move the next one

loop:
  jmp loop

  .org $fffc
  .word main
  .word $0000
