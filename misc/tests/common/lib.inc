;-----------------------------------------------------------------------------
; lib.inc
;-----------------------------------------------------------------------------

	.include "regs.inc"
	.global vera_save, vera_restore

.macro inc16 dst
    .local l1
	inc dst
	bne l1
	inc dst+1
l1:
.endmacro

.macro dec16 dst
    .local l1
	lda dst
	bne l1
	dec dst+1
l1:	dec dst
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
    .local l1
    inc dst
    bne l1
    inc dst+1
    bne l1
    inc dst+2
    bne l1
    inc dst+3
l1:
.endmacro

;-----------------------------------------------------------------------------
; Decrement 32bit number located in memory
;-----------------------------------------------------------------------------
.macro dec32 dst
    .local l1, l2, l3
    lda dst + 0
    bne l3
    lda dst + 1
    bne l2
    lda dst + 2
    bne l1
    dec dst + 3
l1:	dec dst + 2
l2:	dec dst + 1
l3:	dec dst + 0
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
    .local l1
.if count = 1
    lda src
    sta dst
.else
.if count = 2
    lda src
    sta dst
    lda src + 1
    sta dst + 1
.else
	ldy #0
l1:	lda src, y
	sta dst, y
	iny
	cpy #count
	bne l1
.endif
.endif
.endmacro

;-----------------------------------------------------------------------------
; Clear bytes
;-----------------------------------------------------------------------------
.macro clear_bytes dst, count
    .local l1
	ldx #0
l1:	stz dst, x
	inx
	cpx #count
	bne l1
.endmacro
