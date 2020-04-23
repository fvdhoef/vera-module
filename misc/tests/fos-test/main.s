;-----------------------------------------------------------------------------
; fostest.s
;-----------------------------------------------------------------------------

	.include "lib.inc"
	.include "jumptable.inc"

;-----------------------------------------------------------------------------
; Variables
;-----------------------------------------------------------------------------
	.rodata
	.bss
	.zeropage

	.segment "HDR"
	.byte "EXEs"	; Simple executable

;-----------------------------------------------------------------------------
; Entry point
;-----------------------------------------------------------------------------
	.code
	.global entry
entry:
	; jsr clear_screen
	; lda #'!'
	; jsr putchar

	stz VERA_ADDR_L
	stz VERA_ADDR_M
	lda #$10
	sta VERA_ADDR_H

	ldx #0
	lda #'A'

:	sta VERA_DATA0
	stx VERA_DATA0
	inx
	cpx #16
	bne :-


:	bra :-

	rts
