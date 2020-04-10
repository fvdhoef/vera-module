;-----------------------------------------------------------------------------
; main.s
; Copyright (C) 2020 Frank van den Hoef
;-----------------------------------------------------------------------------

	.include "lib.inc"
	.include "text_display.inc"
	.include "fat32.inc"
	.include "text_input.inc"
	.include "cli.inc"

;-----------------------------------------------------------------------------
; Variables
;-----------------------------------------------------------------------------
	.rodata
	.bss
	.zeropage
	.code

;-----------------------------------------------------------------------------
; main
;-----------------------------------------------------------------------------
.proc main
	; Init text display
	jsr text_display_init

	; Print start message
	print_str str_message

	; Start command line interface
	jsr cli_start
	rts

str_message:
	.byte 10,"** Frank's X16 OS **",10,10, 0
.endproc

;-----------------------------------------------------------------------------
; Entry point
;-----------------------------------------------------------------------------
	.global entry
.proc entry
	; Switch to ISO mode
	lda #15
	jsr $FFD2

	; Disable display
	stz VERA_CTRL
	lda VERA_DC_VIDEO
	and #7
	sta VERA_DC_VIDEO

	; Call main
	jsr main
loop:	bra loop
.endproc
