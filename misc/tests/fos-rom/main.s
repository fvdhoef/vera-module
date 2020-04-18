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

	.segment "VECTORS"
.word nmi_entry
.word reset_entry
.word irq_entry

	.code

nmi_entry: rti
irq_entry: rti


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
	.import __BSS_LOAD__
	.import __BSS_SIZE__

.proc reset_entry
	sei	; Disable IRQs
	cld	; Clear decimal mode

	; Clear BSS
	set16_val DST_PTR, __BSS_LOAD__
	add16_val SRC_PTR, DST_PTR, __BSS_SIZE__
:	lda #0
	sta (DST_PTR)
	inc16 DST_PTR
	cmp16 DST_PTR, SRC_PTR, :-

	; Wait for VERA to be ready
vera_wait_ready:
	lda #42
	sta VERA_ADDR_L
	lda VERA_ADDR_L
	cmp #42
	bne vera_wait_ready

	; Init display
	lda #1
	sta VERA_DC_VIDEO

	; Call main
	jsr main
loop:	bra loop
.endproc
