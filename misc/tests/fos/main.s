;-----------------------------------------------------------------------------
; main.s
;-----------------------------------------------------------------------------

	.include "lib.inc"
	.include "text_display.inc"
	.include "fat32.inc"

;-----------------------------------------------------------------------------
; Variables
;-----------------------------------------------------------------------------
	.rodata
	.bss

MAX_LINE_LEN = 78
line_len:
	.byte 0
line_buf:
	.res MAX_LINE_LEN + 1

	.zeropage

	.code

.proc print_dirent
	; Print file name
	ldx #0
:	lda fat32_dirent + dirent::name, x
	beq :+
	jsr putchar
	inx
	bne :-
:
	; Pad spaces
:	cpx #13
	beq :+
	inx
	lda #' '
	jsr putchar
	bra :-
:
	; Print attributes
	lda fat32_dirent + dirent::attributes
	bit #$10
	bne dir

	; Print size
	copy_bytes val32, fat32_dirent + dirent::size, 4
	lda #' '
	sta padch
	jsr print_val32

	bra cluster

dir:	ldy #0
:	lda dirstr, y
	beq :+
	jsr putchar
	iny
	bra :-
:
cluster:
.if 0
	; Spacing
	lda #' '
	jsr putchar

	; Print cluster
	; copy_bytes val32, fat32_dirent + dirent::cluster, 4
	; lda #0
	; sta padch
	; jsr print_val32

	ldx #3
:	lda fat32_dirent + dirent::cluster, x
	jsr puthex
	dex
	cpx #$FF
	bne :-
.endif

	; New line
	lda #10
	jsr putchar

	rts

dirstr: .byte "<DIR>     ", 0
.endproc

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
; toupper
;-----------------------------------------------------------------------------
.proc toupper
	ldx #$FF
next:	inx
	lda line_buf, x
	beq done

	; Lower case character?
	cmp #'a'
	bcc next
	cmp #'z'+1
	bcs next

	; Make uppercase
	and #$DF
	sta line_buf, x
	bra next

done:	rts
.endproc

;-----------------------------------------------------------------------------
; main
;-----------------------------------------------------------------------------
.proc main
	; Switch to ISO mode
	lda #15
	jsr $FFD2

	; Init text display
	jsr text_display_init

	; Print start message
	ldy #0
:	lda message, y
	beq :+
	jsr putchar
	iny
	bra :-
:
	; Get command from user
new_cmd:
	lda #'>'
	jsr putchar
	jsr getline
	jsr toupper

	ldx #0
:	lda line_buf, x
	beq :+
	inx
	jsr putchar
	bra :-
:
	lda #10
	jsr putchar




	bra new_cmd




	; Init FAT32
	jsr fat32_init
	bcs :+
	lda #'0'
	jsr putchar
	rts
:

	; stz SRC_PTR + 0
	; stz SRC_PTR + 1
	; lda #0
	; sta LENGTH + 0
	; lda #$10
	; sta LENGTH + 1

	; jsr hexdump

	; rts

blaat:
	; Context 0: root directory
	lda #0
	jsr fat32_set_context
	copy_bytes fat32_cluster, fat32_rootdir_cluster, 4
	jsr fat32_open_cluster
	bcc error

	; Context 1: sub-directory
	; lda #1
	; jsr fat32_set_context
	; lda #$63
	; sta fat32_cluster + 0
	; stz fat32_cluster + 1
	; stz fat32_cluster + 2
	; stz fat32_cluster + 3
	; jsr fat32_open_cluster
	; bcc error

	; lda #0
	; jsr fat32_set_context

; :	jsr fat32_read_dirent
; 	bcc :+
; 	jsr print_dirent
; 	bra :-
; :

; 	lda #1
; 	jsr fat32_set_context

; 	lda #10
; 	jsr putchar

; :	jsr fat32_read_dirent
; 	bcc :+
; 	jsr print_dirent
; 	bra :-
; :






	; jmp blaat
	; Return
	rts


error:
	rts

message:
	.byte 10,"** Frank's X16 OS **",10,10, 0
.endproc

;-----------------------------------------------------------------------------
; Entry point
;-----------------------------------------------------------------------------
	.global entry
.proc entry
	;rts
	; sei

	; Disable display
	stz VERA_CTRL
	lda VERA_DC_VIDEO
	and #7
	sta VERA_DC_VIDEO

	jsr main
loop:	bra loop
.endproc
