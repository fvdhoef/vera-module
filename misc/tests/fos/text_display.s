;-----------------------------------------------------------------------------
; text_display.s
;-----------------------------------------------------------------------------

	.include "lib.inc"
	.include "text_display.inc"

	.bss
val32:  .dword 0
padch:  .byte 0
line:   .byte 0

	.rodata
font:	.incbin "font8x8.bin"
font_end:

	.code

;-----------------------------------------------------------------------------
; load_font
;-----------------------------------------------------------------------------
.proc load_font
	; Load font into VRAM $1F000
	lda #$00
	sta VERA_ADDR_L
	lda #$F0
	sta VERA_ADDR_M
	lda #$11
	sta VERA_ADDR_H

	lda #<font
	sta SRC_PTR + 0
	lda #>font
	sta SRC_PTR + 1

next:	lda (SRC_PTR)
	sta VERA_DATA0
	inc SRC_PTR + 0
	bne :+
	inc SRC_PTR + 1
:
	lda SRC_PTR + 0
	cmp #<font_end
	bne next
	lda SRC_PTR + 1
	cmp #>font_end
	bne next

	rts
.endproc

;-----------------------------------------------------------------------------
; text_display_init
;-----------------------------------------------------------------------------
.proc text_display_init
	; Load new font
	jsr load_font

	; Set layer 0 tile base
	lda #($1F000 >> 9)
	sta VERA_L0_TILEBASE

	; Set layer 0 map base
	stz VERA_L0_MAPBASE

	; Set layer 0 mode
	lda #$60
	sta VERA_L0_CONFIG

	; Clear screen
	jsr clear_screen

	; Enable layer 0
	lda VERA_DC_VIDEO
	ora #$10
	sta VERA_DC_VIDEO

	rts
.endproc

;-----------------------------------------------------------------------------
; clear_screen
;-----------------------------------------------------------------------------
.proc clear_screen
	stz VERA_ADDR_L
	stz VERA_ADDR_M
	lda #$10
	sta VERA_ADDR_H

	ldy #64
@loop2: ldx #128
@loop1:	lda #' '
	sta VERA_DATA0
	lda #$61
	sta VERA_DATA0
	dex
	bne @loop1
	dey
	bne @loop2

	; Set current position to start of last line
	stz VERA_ADDR_L
	; lda #59
	stz VERA_ADDR_M
	lda #$20
	sta VERA_ADDR_H

	; Reset scroll position
	stz VERA_L0_VSCROLL_L
	stz VERA_L0_VSCROLL_H
	stz line

	rts
.endproc

;-----------------------------------------------------------------------------
; putchar - Print A as character ($A is newline)
;-----------------------------------------------------------------------------
.proc putchar
	pha

	; Remove cursor
	lda #0
	sta VERA_ADDR_H
	lda #' '
	sta VERA_DATA0
	lda #$20
	sta VERA_ADDR_H

	pla
	pha
	; sta $9FB6       ; Emulator output

	; New line?
	cmp #10
	beq newline

	; Backspace
	cmp #8
	beq backspace

	; Print character
	sta VERA_DATA0

	; End of line?
	lda VERA_ADDR_L
	cmp #(80*2)
	beq newline

	; Done
done:   
	; Print cursor
	lda #0
	sta VERA_ADDR_H
	lda #'_'
	sta VERA_DATA0
	lda #$20
	sta VERA_ADDR_H

	pla
	rts

backspace:
	dec VERA_ADDR_L
	dec VERA_ADDR_L
	bra done

newline:
	stz VERA_ADDR_L
	inc VERA_ADDR_M
	lda VERA_ADDR_M
	cmp #64           ; At end of buffer?
	bne erase_line
	stz VERA_ADDR_M   ; Start at begin of buffer again

erase_line:
	; Erase contents of new line
	phx
	ldx #128
@loop1:	lda #' '
	sta VERA_DATA0
	dex
	bne @loop1
	dec VERA_ADDR_M
	plx

	lda line
	cmp #59
	beq scroll
	inc line
	bra done

scroll:
	; Scroll
	clc
	lda VERA_L0_VSCROLL_L
	adc #8
	sta VERA_L0_VSCROLL_L
	lda VERA_L0_VSCROLL_H
	adc #0
	sta VERA_L0_VSCROLL_H

	bra done
.endproc

;-----------------------------------------------------------------------------
; puthex - Print A as hex digits
;-----------------------------------------------------------------------------
.proc puthex
	pha
	phx

	pha
	lsr a
	lsr a
	lsr a
	lsr a
	tax
	lda hexdigits, x
	jsr putchar
	pla
	and #$F
	tax
	lda hexdigits, x
	jsr putchar

	plx
	pla
	rts

hexdigits: .byte "0123456789ABCDEF"
.endproc

;-----------------------------------------------------------------------------
; putstr - Print zero-terminated string in SRC_PTR
; clobbers: A,X
;-----------------------------------------------------------------------------
.proc putstr
next:	lda (SRC_PTR)
	beq done
	jsr putchar

	inc SRC_PTR + 0
	bne :+
	inc SRC_PTR + 1
:	bra next
done:	rts
.endproc

;-----------------------------------------------------------------------------
; hexdump16 - Dump 16 bytes from address SRC_PTR
; clobbers: A,Y
;-----------------------------------------------------------------------------
.proc hexdump16
	; Print address
	lda SRC_PTR + 1
	jsr puthex
	lda SRC_PTR + 0
	jsr puthex

	; Separator
	lda #' '
	jsr putchar
	jsr putchar

	; Print 16 hex bytes separated by space
	ldy #8
loop:	lda (SRC_PTR)
	jsr puthex
	lda #' '
	jsr putchar
	inc SRC_PTR + 0
	bne :+
	inc SRC_PTR + 1
:	dey
	bne loop

	lda #' '
	jsr putchar

	ldy #8
loop2:	lda (SRC_PTR)
	jsr puthex
	lda #' '
	jsr putchar
	inc SRC_PTR + 0
	bne :+
	inc SRC_PTR + 1
:	dey
	bne loop2

	; Separator
	lda #' '
	jsr putchar
	lda #'|'
	jsr putchar

	; Decrease pointer by 16 bytes
	sec
	lda SRC_PTR + 0
	sbc #16
	sta SRC_PTR + 0
	lda SRC_PTR + 1
	sbc #0
	sta SRC_PTR + 1

	; Print 16 bytes as text
	ldy #16
loop3:	lda (SRC_PTR)

	; Replace potential control characters before printing
	cmp #32
	bcc replace_char
	cmp #127
	bcs replace_char
outchar:
	jsr putchar

	; Increase pointer
	inc SRC_PTR + 0
	bne :+
	inc SRC_PTR + 1
:
	dey
	bne loop3

	; Separator and newline
	lda #'|'
	jsr putchar
	lda #$A
	jsr putchar

	rts

replace_char:
	lda #'.'	;$FA
	bra outchar
.endproc

;-----------------------------------------------------------------------------
; hexdump - Dump LENGTH bytes (rounded up to next 16 byte boundary)
;           from address SRC_PTR
; clobbers: A,Y
;-----------------------------------------------------------------------------
.proc hexdump
loop:
	; Dump 16 bytes at SRC_PTR
	jsr hexdump16

	; Decrease length by 16 bytes
	sec
	lda LENGTH + 0
	sbc #16
	sta LENGTH + 0
	lda LENGTH + 1
	sbc #0
	sta LENGTH + 1
	bcc done

	; Check if length == 0
	bne loop
	lda LENGTH + 0
	bne loop

done:	rts
.endproc

;-----------------------------------------------------------------------------
; print_val32 - Print number in val32 as decimal
;
; Pad character in padch: 0 (no padding) or '0' / ' '
; clobbers: A, X, Y, val32, padch
;-----------------------------------------------------------------------------
.proc print_val32
	ldy #(9 * 4)		; Offset to powers of ten
loop1:	ldx #$FF		; Start with digit=-1
	sec
loop2:	lda val32 + 0		; Subtract current tens
	sbc tens + 0, y
	sta val32 + 0
	lda val32 + 1
	sbc tens + 1, y
	sta val32 + 1
	lda val32 + 2
	sbc tens + 2, y
	sta val32 + 2
	lda val32 + 3
	sbc tens + 3, y
	sta val32 + 3
	inx
	bcs loop2		; Loop until <0

	lda val32 + 0		; Add current tens back in
	adc tens + 0, y
	sta val32 + 0
	lda val32 + 1
	adc tens + 1, y
	sta val32 + 1
	lda val32 + 2
	adc tens + 2, y
	sta val32 + 2
	lda val32 + 3
	adc tens + 3, y
	sta val32 + 3

	txa
	bne digit		; Not zero, print it
	cpy #0			; Lowest digit is always printed
	beq digit

	lda padch
	bne print
	beq next		; padch != 0, use it
digit:
	ldx #'0'
	stx padch		; No more zero padding
	ora #'0'		; Print this digit
print:
	jsr putchar
next:
	dey
	dey
	dey
	dey
	bpl loop1		; Loop for next digit
	rts

tens:
   .dword 1
   .dword 10
   .dword 100
   .dword 1000
   .dword 10000
   .dword 100000
   .dword 1000000
   .dword 10000000
   .dword 100000000
   .dword 1000000000
.endproc
