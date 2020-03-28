;-----------------------------------------------------------------------------
; text_input.s
;-----------------------------------------------------------------------------

        .include "text_input.inc"
	.include "lib.inc"
	.include "text_display.inc"

;-----------------------------------------------------------------------------
; Variables
;-----------------------------------------------------------------------------
	.bss
line_len:
	.byte 0
line_buf:
	.res MAX_LINE_LEN + 1
line_start:
	.byte 0

	.code

;-----------------------------------------------------------------------------
; getchar
;-----------------------------------------------------------------------------
.proc getchar
:	jsr $FFE4
	beq :-

	cmp #13
	beq enter
	cmp #20
	beq backspace
	rts

enter:	lda #10
	rts
backspace:
	lda #8
	rts
.endproc

;-----------------------------------------------------------------------------
; getline
;-----------------------------------------------------------------------------
.proc getline
	stz line_len
	stz line_start

next_char:
	jsr getchar

	cmp #10
	beq enter
	cmp #8
	beq backspace

	ldx line_len
	cpx #MAX_LINE_LEN
	beq next_char

	sta line_buf, x
	inc line_len

	jsr putchar

	bra next_char

backspace:
	ldx line_len
	beq next_char
	dec line_len
	jsr putchar
	bra next_char

enter:	jsr putchar

	; Zero terminate line_buf
	ldx line_len
	stz line_buf, x
	rts
.endproc

;-----------------------------------------------------------------------------
; skip_spaces
;-----------------------------------------------------------------------------
.proc skip_spaces
	ldx line_start
	dex
:	inx
	lda line_buf, x
	cmp #' '
	beq :-

	stx line_start
	rts
.endproc

;-----------------------------------------------------------------------------
; to_upper
;-----------------------------------------------------------------------------
.proc to_upper
	; Lower case character?
	cmp #'a'
	bcc done
	cmp #'z'+1
	bcs done

	; Make uppercase
	and #$DF
done:
	rts
.endproc

;-----------------------------------------------------------------------------
; first_word_to_upper
;-----------------------------------------------------------------------------
.proc first_word_to_upper
	ldx line_start
	dex
next:	inx
	lda line_buf, x
	beq done
	cmp #' '
	beq done
	jsr to_upper
	sta line_buf, x
	bra next
done:
	rts
.endproc
