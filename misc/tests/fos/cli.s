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
	.local l1

	.byte l1 - *
	.word handler
	.byte cmd, 0
l1:
.endmacro

	.rodata
cmd_table:
	def_cmd "CD",      cmd_cd       ; Change directory
	def_cmd "CLS",     cmd_cls      ; Clear screen
	def_cmd "COPY",    cmd_copy     ; Copy file
	def_cmd "DEL",     cmd_del      ; Delete file
	def_cmd "DIR",     cmd_dir      ; List directory
	def_cmd "HELP",    cmd_help     ; Show available commands
	def_cmd "HEXDUMP", cmd_hexdump  ; Hexdump contents of file
	def_cmd "LOAD",    cmd_load     ; Load file
	def_cmd "MOVE",    cmd_move     ; Move file
	def_cmd "RENAME",  cmd_rename   ; Rename file
	def_cmd "TYPE",    cmd_type     ; Print contents of file
	.byte 0

	.code

;-----------------------------------------------------------------------------
; cli_start
;-----------------------------------------------------------------------------
.proc cli_start
	; Init FAT32
	jsr fat32_init
	bcs :+
	lda #'0'
	jsr putchar
	rts
:
	; Get commands from user
next_cmd:
	; Print prompt
	lda #'>'
	jsr putchar

	; Get line from user
	jsr getline
	jsr skip_spaces
	jsr first_word_to_upper

	; Empty line?
	ldx line_start
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
	jsr skip_spaces

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
	stx line_start
	jsr skip_spaces

	; Get function pointer
	ldy #1
	lda (SRC_PTR), y
	sta DST_PTR + 0
	iny
	lda (SRC_PTR), y
	sta DST_PTR + 1

	; Call handler function
	jmp (DST_PTR)

done:	
	; Print error message
	print_str str_cmd_not_found
	rts

str_cmd_not_found: .byte "Command not found!",10,0
.endproc

;-----------------------------------------------------------------------------
; cmd_dir
;-----------------------------------------------------------------------------
.proc cmd_dir
	; Open current directory
	jsr fat32_open_cwd
	bcs :+
	rts
:
	; Print entries
:	jsr fat32_read_dirent
	bcc :+
	jsr print_dirent
	bra :-
:
	rts
.endproc

.proc check_no_params
	ldx line_start
	lda line_buf, x
	beq ok
	jmp syntax_error
ok:	sec
	rts
.endproc

.proc set_param1
	clc
	lda #<line_buf
	adc line_start
	sta fat32_ptr + 0
	lda #>line_buf
	adc #0
	sta fat32_ptr + 1

	jmp terminate_and_skip_to_next_word
.endproc

.proc set_param2
	clc
	lda #<line_buf
	adc line_start
	sta fat32_ptr2 + 0
	lda #>line_buf
	adc #0
	sta fat32_ptr2 + 1

	jmp terminate_and_skip_to_next_word
.endproc

.proc set_single_param
	; Check if string isn't empty
	ldx line_start
	lda line_buf, x
	bne ok
	jmp syntax_error
ok:
	; Transform argument to uppercase
	jsr first_word_to_upper

	; Set param 1
	jsr set_param1
	bcs error
	sec
	rts

error:	jsr syntax_error
	clc
	rts
.endproc

.proc set_two_params
	; Check if string isn't empty
	ldx line_start
	lda line_buf, x
	bne :+
	jmp syntax_error
:
	; Transform argument to uppercase
	jsr first_word_to_upper

	; Set param 1
	jsr set_param1
	bcc error

	; Check if string isn't empty
	ldx line_start
	lda line_buf, x
	bne :+
	jmp syntax_error
:
	; Transform argument to uppercase
	jsr first_word_to_upper

	; Set param 2
	jsr set_param2
	bcs error

	sec
	rts

error:	jsr syntax_error
	clc
	rts
.endproc

.proc syntax_error
	print_str str_syntax_error
	clc
	rts

str_syntax_error: .byte "Syntax error!", 10,0
.endproc

;-----------------------------------------------------------------------------
; cmd_cd
;-----------------------------------------------------------------------------
.proc cmd_cd
	; Change directory
	jsr set_single_param
	bcs :+
	rts
:	jsr fat32_chdir
	bcs done
	print_str str_dir_not_found
done:	rts

str_dir_not_found: .byte "Directory not found!",10,0
.endproc

;-----------------------------------------------------------------------------
; cmd_type
;-----------------------------------------------------------------------------
.proc cmd_type
	; Open file
	jsr set_single_param
	bcs :+
	rts
:	jsr fat32_open_file
	bcs ok

	; Opening file failed, print error message
	print_str str_file_not_found
	rts
ok:
	; Print contents
:	jsr fat32_get_byte
	bcc done
	jsr putchar
	bra :-
done:
	; Print new line
	lda #10
	jsr putchar
	rts

str_file_not_found: .byte "File not found!",10,0
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
	jsr check_no_params
	bcs :+
	rts
:
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

;-----------------------------------------------------------------------------
; cmd_cls
;-----------------------------------------------------------------------------
.proc cmd_cls
	jsr check_no_params
	bcs :+
	rts
:
	jsr clear_screen
	rts
.endproc

;-----------------------------------------------------------------------------
; cmd_rename
;-----------------------------------------------------------------------------
.proc cmd_rename
	jsr set_two_params
	bcs :+
	rts
:
	jsr fat32_rename
	bcs :+
	print_str str_error
:
	rts

str_error: .byte "Error!",10,0
.endproc

;-----------------------------------------------------------------------------
; cmd_copy
;-----------------------------------------------------------------------------
.proc cmd_copy
	rts
.endproc

;-----------------------------------------------------------------------------
; cmd_move
;-----------------------------------------------------------------------------
.proc cmd_move
	rts
.endproc

;-----------------------------------------------------------------------------
; cmd_del
;-----------------------------------------------------------------------------
.proc cmd_del
	; Open file
	jsr set_single_param
	bcs :+
	rts
:
	jsr fat32_delete
	bcs :+
	print_str str_error
:
	rts

str_error: .byte "Error!",10,0
.endproc

;-----------------------------------------------------------------------------
; cmd_hexdump
;-----------------------------------------------------------------------------
.proc cmd_hexdump
	rts
.endproc
