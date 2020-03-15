;-----------------------------------------------------------------------------
; 1bpptest.s
;-----------------------------------------------------------------------------

	.include "lib.inc"

;-----------------------------------------------------------------------------
; Variables
;-----------------------------------------------------------------------------
	.rodata
image:	.incbin "img.raw"

	.zeropage
ptr:	.word 0

;-----------------------------------------------------------------------------
; Entry point
;-----------------------------------------------------------------------------
	.code
	.global entry
entry:
	; Init palette
	stz VERA_ADDR_L
	lda #$FA
	sta VERA_ADDR_M
	lda #$11
	sta VERA_ADDR_H

	stz VERA_DATA0	; Idx 0: black
	stz VERA_DATA0
	lda #$FF
	sta VERA_DATA0	; Idx 1: white
	lda #$0F
	sta VERA_DATA0

	; Layer 0, 1bpp bitmap mode
	lda #$04
	sta VERA_L0_CONFIG
	stz VERA_L0_MAPBASE
	lda #$01
	sta VERA_L0_TILEBASE
	stz VERA_L0_HSCROLL_L
	stz VERA_L0_HSCROLL_H
	stz VERA_L0_VSCROLL_L
	stz VERA_L0_VSCROLL_H

	; Enable layer 0 + VGA output
	lda #$11
	sta VERA_DC_VIDEO


	lda #<image
	sta ptr
	lda #>image
	sta ptr+1

	stz VERA_ADDR_L
	stz VERA_ADDR_M
	lda #$10
	sta VERA_ADDR_H

	ldx #0
	ldy #150
@again:	lda (ptr)
	sta VERA_DATA0
	inc ptr
	bne @noinc
	inc ptr+1
@noinc:	dex
	bne @again
	dey
	bne @again


loop:	jmp loop
