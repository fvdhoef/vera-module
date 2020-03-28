;-----------------------------------------------------------------------------
; cli.s
;-----------------------------------------------------------------------------

	.include "cli.inc"
	.include "lib.inc"
	.include "text_display.inc"
	.include "text_input.inc"
	.include "fat32.inc"
	.include "fat32_util.inc"

;-----------------------------------------------------------------------------
; Variables
;-----------------------------------------------------------------------------
.macro def_cmd cmd, handler
	.byte :+ - *
	.word handler
	.byte cmd, 0
:
.endmacro

	.rodata
cmd_table:
	def_cmd "CD", cmd_cd
	def_cmd "CLS", cmd_cls
	def_cmd "DIR", cmd_dir
	def_cmd "HELP", cmd_help
	def_cmd "LOAD", cmd_load
	def_cmd "TYPE", cmd_type
	.byte 0

	.bss
	.zeropage

	.code

;-----------------------------------------------------------------------------
; cli_start
;-----------------------------------------------------------------------------
.proc cli_start
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

	rts
.endproc

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
