;-----------------------------------------------------------------------------
; vera.s
; Copyright (C) 2020 Frank van den Hoef
;-----------------------------------------------------------------------------

        .include "vera.inc"
        .include "regs.inc"

	.rodata
palette:
	.word $000, $125, $725, $085, $A53, $555, $CCC, $FFF, $F04, $FA0, $FE3, $0E3, $3AF, $879, $F7A, $FCA    ; PICO8 based palette
	; .word $000, $FFF, $800, $AFE, $C4C, $0C5, $00A, $EE7, $D85, $640, $F77, $333, $777, $AF6, $08F, $BBB
	.word $000, $111, $222, $333, $444, $555, $666, $777, $888, $999, $AAA, $BBB, $CCC, $DDD, $EEE, $FFF
	.word $211, $433, $644, $866, $A88, $C99, $FBB, $211, $422, $633, $844, $A55, $C66, $F77, $200, $411
	.word $611, $822, $A22, $C33, $F33, $200, $400, $600, $800, $A00, $C00, $F00, $221, $443, $664, $886
	.word $AA8, $CC9, $FEB, $211, $432, $653, $874, $A95, $CB6, $FD7, $210, $431, $651, $862, $A82, $CA3
	.word $FC3, $210, $430, $640, $860, $A80, $C90, $FB0, $121, $343, $564, $786, $9A8, $BC9, $DFB, $121
	.word $342, $463, $684, $8A5, $9C6, $BF7, $120, $241, $461, $582, $6A2, $8C3, $9F3, $120, $240, $360
	.word $480, $5A0, $6C0, $7F0, $121, $343, $465, $686, $8A8, $9CA, $BFC, $121, $242, $364, $485, $5A6
	.word $6C8, $7F9, $020, $141, $162, $283, $2A4, $3C5, $3F6, $020, $041, $061, $082, $0A2, $0C3, $0F3
	.word $122, $344, $466, $688, $8AA, $9CC, $BFF, $122, $244, $366, $488, $5AA, $6CC, $7FF, $022, $144
	.word $166, $288, $2AA, $3CC, $3FF, $022, $044, $066, $088, $0AA, $0CC, $0FF, $112, $334, $456, $668
	.word $88A, $9AC, $BCF, $112, $224, $346, $458, $56A, $68C, $79F, $002, $114, $126, $238, $24A, $35C
	.word $36F, $002, $014, $016, $028, $02A, $03C, $03F, $112, $334, $546, $768, $98A, $B9C, $DBF, $112
	.word $324, $436, $648, $85A, $96C, $B7F, $102, $214, $416, $528, $62A, $83C, $93F, $102, $204, $306
	.word $408, $50A, $60C, $70F, $212, $434, $646, $868, $A8A, $C9C, $FBE, $211, $423, $635, $847, $A59
	.word $C6B, $F7D, $201, $413, $615, $826, $A28, $C3A, $F3C, $201, $403, $604, $806, $A08, $C09, $F0B

	.bss
vera_output_mode: .byte 0

        .code
;-----------------------------------------------------------------------------
; vera_reset_settings
;-----------------------------------------------------------------------------
.proc vera_reset_settings
	;---------------------------------------
	; Interrupts
	;---------------------------------------
	stz VERA_IEN
	stz VERA_IRQ_LINE_L

	;---------------------------------------
	; Display composer
	;---------------------------------------

	; Disable active layers
	stz VERA_CTRL
	lda vera_output_mode
	and #$0F
	sta VERA_DC_VIDEO

	; Reset display scaling
	lda #128
	sta VERA_DC_HSCALE
	sta VERA_DC_VSCALE

	; Reset display H/V start/stop
	lda #2
	sta VERA_CTRL
	stz VERA_DC_HSTART
	lda #(640>>2)
	sta VERA_DC_HSTOP
	stz VERA_DC_VSTART
	lda #(480>>1)
	sta VERA_DC_VSTOP
	stz VERA_CTRL

	; Reset border color
	stz VERA_DC_BORDER

	;---------------------------------------
	; Layer 0
	;---------------------------------------
	stz VERA_L0_CONFIG
	stz VERA_L0_MAPBASE
	stz VERA_L0_TILEBASE
	stz VERA_L0_HSCROLL_L
	stz VERA_L0_HSCROLL_H
	stz VERA_L0_VSCROLL_L
	stz VERA_L0_VSCROLL_H

	;---------------------------------------
	; Layer 0
	;---------------------------------------
	stz VERA_L1_CONFIG
	stz VERA_L1_MAPBASE
	stz VERA_L1_TILEBASE
	stz VERA_L1_HSCROLL_L
	stz VERA_L1_HSCROLL_H
	stz VERA_L1_VSCROLL_L
	stz VERA_L1_VSCROLL_H

	;---------------------------------------
	; Audio
	;---------------------------------------
	stz VERA_AUDIO_CTRL
	stz VERA_AUDIO_RATE

	;---------------------------------------
	; SPI
	;---------------------------------------
	stz VERA_SPI_CTRL

	;---------------------------------------
	; Clear PSG registers
	;---------------------------------------
	lda #$11
	sta VERA_ADDR_H
	lda #$F9
	sta VERA_ADDR_M
	ldx #$C0
	stx VERA_ADDR_L

:	stz VERA_DATA0
	inx
	bne :-

	;---------------------------------------
	; Reset palette
	;---------------------------------------
	lda #$11
	sta VERA_ADDR_H
	lda #$FA
	sta VERA_ADDR_M
	stz VERA_ADDR_L

	ldx #$00
:	lda palette, x
	sta VERA_DATA0
	inx
	bne :-
:	lda palette + 256, x
	sta VERA_DATA0
	inx
	bne :-

	;---------------------------------------
	; Clear sprite attributes
	;---------------------------------------
	ldy #$FC
	sty VERA_ADDR_M
	ldx #$00
	stx VERA_ADDR_L

:	stz VERA_DATA0
	inx
	bne :-
	iny
	bne :-

	;---------------------------------------
	; Data ports
	;---------------------------------------
	lda #1
	sta VERA_CTRL
	stz VERA_ADDR_L
	stz VERA_ADDR_M
	stz VERA_ADDR_H
	stz VERA_CTRL
	stz VERA_ADDR_L
	stz VERA_ADDR_M
	stz VERA_ADDR_H

	;---------------------------------------
	; Clear interrupts
	;---------------------------------------
	lda #$0F
	sta VERA_ISR

	rts
.endproc
