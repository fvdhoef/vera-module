;-----------------------------------------------------------------------------
; lib.inc
;-----------------------------------------------------------------------------

	.include "regs.inc"
	.global vera_save, vera_restore

.macro inc16 dst
	inc dst
	bne :+
	inc dst+1
:
.endmacro

.macro dec16 dst
	lda dst
	bne :+
	dec dst+1
:	dec dst
.endmacro

;-----------------------------------------------------------------------------
; Add two 32bit numbers located in memory
;-----------------------------------------------------------------------------
.macro add32 dst, src0, src1
    clc
    lda src0+0
    adc src1+0
    sta dst+0
    lda src0+1
    adc src1+1
    sta dst+1
    lda src0+2
    adc src1+2
    sta dst+2
    lda src0+3
    adc src1+3
    sta dst+3
.endmacro

;-----------------------------------------------------------------------------
; Add 32bit and 16bit number located in memory
;-----------------------------------------------------------------------------
.macro add32_16 dst, src0, src1
    clc

    lda src0+0
    adc src1+0
    sta dst+0

    lda src0+1
    adc src1+1
    sta dst+1

    lda src0+2
    adc #0
    sta dst+2

    lda src0+3
    adc #0
    sta dst+3
.endmacro

;-----------------------------------------------------------------------------
; Increment 32bit number located in memory
;-----------------------------------------------------------------------------
.macro inc32 dst
    inc dst
    bne :+
    inc dst+1
    bne :+
    inc dst+2
    bne :+
    inc dst+3
:
.endmacro

;-----------------------------------------------------------------------------
; Subtract immediate value from 32bit number located in memory
;-----------------------------------------------------------------------------
.macro sub32_val dst, src, val
	sec
	lda src+0
	sbc #<val
	sta dst+0

	lda src+1
	sbc #>val
	sta dst+1

	lda src+2
	sbc #^val
	sta dst+2

	lda src+3
	sbc #(.hibyte(.hiword(val)))
	sta dst+3
.endmacro

;-----------------------------------------------------------------------------
; Copy bytes
;-----------------------------------------------------------------------------
.macro copy_bytes dst, src, count
	ldy #0
:	lda src, y
	sta dst, y
	iny
	cpy #count
	bne :-
.endmacro

;-----------------------------------------------------------------------------
; Clear bytes
;-----------------------------------------------------------------------------
.macro clear_bytes dst, count
	ldx #0
:	stz dst, x
	inx
	cpx #count
	bne :-
.endmacro
