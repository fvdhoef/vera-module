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
line_start:
	.byte 0

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
; cmd_dir
;-----------------------------------------------------------------------------
.proc cmd_dir
	; Init FAT32
	jsr fat32_init
	bcs :+
	lda #'0'
	jsr putchar
	rts
:
	; Context 0: root directory
	lda #0
	jsr fat32_set_context
	copy_bytes fat32_cluster, fat32_rootdir_cluster, 4
	jsr fat32_open_cluster
	bcc error

	; Print entries
:	jsr fat32_read_dirent
	bcc :+
	jsr print_dirent
	bra :-
:

error:
	rts
.endproc

;-----------------------------------------------------------------------------
; cmd_cd
;-----------------------------------------------------------------------------
.proc cmd_cd
	lda #'C'
	jsr putchar

	jsr skip_spaces
	ldx line_start
:	lda line_buf, x
	beq :+
	inx
	jsr putchar
	bra :-
:
	rts
.endproc

;-----------------------------------------------------------------------------
; cmd_type
;-----------------------------------------------------------------------------
.proc cmd_type
	; Init FAT32
	jsr fat32_init
	bcs :+
	lda #'0'
	jsr putchar
	rts
:
	; Context 0: root directory
	lda #0
	jsr fat32_set_context
	copy_bytes fat32_cluster, fat32_rootdir_cluster, 4
	jsr fat32_open_cluster
	bcc file_not_found

	; Skip spaces in command parameter
	jsr skip_spaces

	; Find file
	clc
	lda #<line_buf
	adc line_start
	sta fat32_ptr + 0
	lda #>line_buf
	adc #0
	sta fat32_ptr + 1

	jsr fat32_find_file
	bcc file_not_found

	; Open file
	copy_bytes fat32_cluster, fat32_dirent + dirent::cluster, 4
	jsr fat32_open_cluster
	bcc file_not_found

	; Print contents
:	jsr fat32_get_byte
	bcc done
	jsr putchar
	bra :-

done:
	lda #10
	jsr putchar
	rts

file_not_found:
	; Print error message
	ldy #0
:	lda file_not_found_str, y
	beq :+
	jsr putchar
	iny
	bra :-
:
	rts

file_not_found_str: .byte "File not found!",10,0
.endproc

;-----------------------------------------------------------------------------
; cmd_load
;-----------------------------------------------------------------------------
.proc cmd_load
	lda #'L'
	jsr putchar
	rts
.endproc

;-----------------------------------------------------------------------------
; cmd_help
;-----------------------------------------------------------------------------
.proc cmd_help
	lda #<cmd_table
	sta SRC_PTR + 0
	lda #>cmd_table
	sta SRC_PTR + 1

loop:	lda (SRC_PTR)
	beq done

	; Print command name
	ldy #3
:	lda (SRC_PTR), y
	beq :+
	jsr putchar
	iny
	bra :-
:
	; Print space
	lda #' '
	jsr putchar

	; Move to next command
	clc
	lda SRC_PTR + 0
	adc (SRC_PTR)
	sta SRC_PTR + 0
	lda SRC_PTR + 1
	adc #0
	sta SRC_PTR + 1
	bra loop

done:	lda #10
	jsr putchar
	rts
.endproc

.proc cmd_cls
	jsr clear_screen
	rts
.endproc

;-----------------------------------------------------------------------------
; Command table
;-----------------------------------------------------------------------------
.macro def_cmd cmd, handler
	.byte :+ - *
	.word handler
	.byte cmd, 0
:
.endmacro

cmd_table:
	def_cmd "CD", cmd_cd
	def_cmd "CLS", cmd_cls
	def_cmd "DIR", cmd_dir
	def_cmd "HELP", cmd_help
	def_cmd "LOAD", cmd_load
	def_cmd "TYPE", cmd_type
	.byte 0

;-----------------------------------------------------------------------------
; call_cmd
;-----------------------------------------------------------------------------
.proc call_cmd
	lda #<cmd_table
	sta SRC_PTR + 0
	lda #>cmd_table
	sta SRC_PTR + 1

	; Compare entry against line buffer
check:	lda (SRC_PTR)
	beq done

	ldx line_start
	ldy #3
:	lda (SRC_PTR), y
	beq match
	cmp line_buf, x
	bne nomatch
	inx
	iny
	bra :-

	; Proceed to next entry
nomatch:
	clc
	lda SRC_PTR + 0
	adc (SRC_PTR)
	sta SRC_PTR + 0
	lda SRC_PTR + 1
	adc #0
	sta SRC_PTR + 1
	bra check

	; Potential match, check if command is followed by 0-termination or space
match:	lda line_buf, x
	beq match_ok
	cmp #' '
	beq match_ok
	bra nomatch

match_ok:
	ldy #1
	lda (SRC_PTR), y
	sta DST_PTR + 0
	iny
	lda (SRC_PTR), y
	sta DST_PTR + 1
	stx line_start

	jmp (DST_PTR)

done:	
	; Print error message
	ldy #0
:	lda cmd_not_found, y
	beq :+
	jsr putchar
	iny
	bra :-
:
	rts

cmd_not_found: .byte "Command not found!",10,0
.endproc

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
	; Get commands from user
next_cmd:
	; Print prompt
	lda #'>'
	jsr putchar

	; Get line from user
	jsr getline

	; Transform characters in line to upper case
	jsr toupper

	; Skip spaces (first non-space character in x and line_start)
	jsr skip_spaces

	; Empty line?
	lda line_buf, x
	beq next_cmd

	; Search and call command
	jsr call_cmd
	bra next_cmd



	; Parse command
; 	ldx #0
; :	lda line_buf, x
; 	beq :+
; 	inx
; 	jsr putchar
; 	bra :-
; :
	; lda #10
	; jsr putchar






	; stz SRC_PTR + 0
	; stz SRC_PTR + 1
	; lda #0
	; sta LENGTH + 0
	; lda #$10
	; sta LENGTH + 1

	; jsr hexdump

	; rts

blaat:

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
