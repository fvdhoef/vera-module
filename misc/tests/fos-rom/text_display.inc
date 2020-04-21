;-----------------------------------------------------------------------------
; text_display.inc
; Copyright (C) 2020 Frank van den Hoef
;-----------------------------------------------------------------------------

;-----------------------------------------------------------------------------
; Macros
;-----------------------------------------------------------------------------

.macro print_str str
	.local l1, l2
	ldy #0
l1:	lda str, y
	beq l2
	jsr putchar
	iny
	bra l1
l2:
.endmacro

;-----------------------------------------------------------------------------
; Functions
;-----------------------------------------------------------------------------
.global text_display_init
.global clear_screen
.global putchar
.global putstr
.global puthex
.global hexdump
.global print_val32
