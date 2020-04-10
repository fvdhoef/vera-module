;-----------------------------------------------------------------------------
; lib.s
; Copyright (C) 2020 Frank van den Hoef
;-----------------------------------------------------------------------------

	.include "lib.inc"
	.global entry

;-----------------------------------------------------------------------------
; Program header and BASIC code
;-----------------------------------------------------------------------------
	.segment "PRGHDR"

prghdr: .word @basic
@basic:	.word @next, 10		; Next line pointer and current line number
	.byte $9E, " 2062", 0	; SYS 2062
@next:	.word 0			; End of program
	jmp entry


	.code

;-----------------------------------------------------------------------------
; vera_save
;-----------------------------------------------------------------------------
	.global vera_save
vera_save:
	plx
	ply
	lda VERA_CTRL
	pha
	stz VERA_CTRL
	lda VERA_ADDR_L
	pha
	lda VERA_ADDR_M
	pha
	lda VERA_ADDR_H
	pha
	phy
	phx
	rts

;-----------------------------------------------------------------------------
; vera_restore
;-----------------------------------------------------------------------------
	.global vera_restore
vera_restore:
	plx
	ply
	pla
	sta VERA_ADDR_H
	pla
	sta VERA_ADDR_M
	pla
	sta VERA_ADDR_L
	pla
	sta VERA_CTRL
	phy
	phx
	rts
