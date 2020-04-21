;-----------------------------------------------------------------------------
; cli.s
; Copyright (C) 2020 Frank van den Hoef
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
	def_cmd "DEL",     cmd_delete   ; Delete file
	def_cmd "DIR",     cmd_dir      ; List directory
	def_cmd "HELP",    cmd_help     ; Show available commands
	def_cmd "MKDIR",   cmd_mkdir    ; Make directory
	def_cmd "REN",     cmd_rename   ; Rename file
	def_cmd "RMDIR",   cmd_rmdir    ; Remove directory
	def_cmd "RUN",     cmd_run      ; Run program

	def_cmd "TYPE",    cmd_type     ; Print contents of file
	def_cmd "TEST",    cmd_test
	def_cmd "TEST2",   cmd_test2
	def_cmd "TEST3",   cmd_test3
	def_cmd "MOVIE",   cmd_movie
	.byte 0

	.bss
num_files:  .word 0
num_dirs:   .word 0
total_size: .dword 0
tmp_param:  .word 0

	.code

AUTORUN=1

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
.ifdef AUTORUN
	ldx #$FF
:	inx
	lda cmd, x
	sta line_buf, x
	bne :-
	bra l1
.endif
	; Get commands from user
next_cmd:
	; Print prompt
	lda #'>'
	jsr putchar

	; Get line from user
	jsr getline
l1:	jsr skip_spaces
	jsr first_word_to_upper

	; Empty line?
	ldx line_start
	lda line_buf, x
	beq next_cmd

	; Search and call command
	jsr call_cmd
	bra next_cmd

cmd: .byte "run fostest.prg",0
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
	set16_val num_files, 0
	set16_val num_dirs, 0
	set32_val total_size, 0

	; Open current directory
	jsr fat32_open_cwd
	bcs :+
	rts
:
	; Print entries
next:	jsr fat32_read_dirent
	bcc done

	lda fat32_dirent + dirent::attributes
	bit #$10
	beq is_file

is_dir:
	inc16 num_dirs
	bra print

is_file:
	add32 total_size, total_size, fat32_dirent + dirent::size
	inc16 num_files

print:
	jsr print_dirent
	bra next
done:
	jsr fat32_close

	; Print number of files
	set16 val32, num_files
	set16_val val32+2, 0
	lda #' '
	sta padch
	jsr print_val32
	print_str str_files

	; Print total file size
	set32 val32, total_size
	lda #' '
	sta padch
	jsr print_val32
	print_str str_bytes

	; Print number of dirs
	set16 val32, num_dirs
	set16_val val32+2, 0
	lda #' '
	sta padch
	jsr print_val32
	print_str str_dirs

	; Print free size
	jsr fat32_get_free_space
	set32 val32, fat32_size
	lda #' '
	sta padch
	jsr print_val32
	print_str str_bytes_free

	rts

str_files: .byte " files(s)", 0
str_bytes: .byte " bytes", 10, 0
str_dirs:  .byte " dir(s)  ", 0
str_bytes_free: .byte " KiB free", 10, 0
.endproc

;-----------------------------------------------------------------------------
; check_no_params
;-----------------------------------------------------------------------------
.proc check_no_params
	ldx line_start
	lda line_buf, x
	beq ok
	jmp syntax_error
ok:	sec
	rts
.endproc

;-----------------------------------------------------------------------------
; set_param1
;-----------------------------------------------------------------------------
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

;-----------------------------------------------------------------------------
; set_param2
;-----------------------------------------------------------------------------
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

;-----------------------------------------------------------------------------
; set_single_param
;-----------------------------------------------------------------------------
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

;-----------------------------------------------------------------------------
; set_two_params
;-----------------------------------------------------------------------------
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

;-----------------------------------------------------------------------------
; syntax_error
;-----------------------------------------------------------------------------
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
:	jsr fat32_open
	bcs ok

	; Opening file failed, print error message
	print_str str_file_not_found
	rts
ok:
	; Print contents
:	jsr fat32_read_byte
	bcc done
	jsr putchar
	bra :-
done:
	jsr fat32_close

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
	jsr set_two_params
	bcs :+
	rts
:
	set16 tmp_param, fat32_ptr2

	lda #0
	jsr fat32_set_context
	bcc error
	jsr fat32_open
	bcc error

	lda #1
	jsr fat32_set_context
	bcc error
	set16 fat32_ptr, tmp_param
	jsr fat32_create
	bcc error


loop:	lda #'.'
	jsr putchar

	lda #0
	jsr fat32_set_context
	set16_val fat32_ptr, $4000
	set16_val fat32_size, $4000
	jsr fat32_read

	lda fat32_size + 0
	ora fat32_size + 1
	beq done

	lda #1
	jsr fat32_set_context
	set16_val fat32_ptr, $4000
	jsr fat32_write

	bra loop
done:

error:	lda #1
	jsr fat32_set_context
	jsr fat32_close
	lda #0
	jsr fat32_set_context
	jsr fat32_close
	rts
.endproc

;-----------------------------------------------------------------------------
; cmd_delete
;-----------------------------------------------------------------------------
.proc cmd_delete
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
; cmd_mkdir
;-----------------------------------------------------------------------------
.proc cmd_mkdir
	jsr set_single_param
	bcs :+
	rts
:
	jsr fat32_mkdir
	bcs :+
	print_str str_error
:
	rts

str_error: .byte "Error!",10,0
.endproc

;-----------------------------------------------------------------------------
; cmd_rmdir
;-----------------------------------------------------------------------------
.proc cmd_rmdir
	jsr set_single_param
	bcs :+
	rts
:
	jsr fat32_rmdir
	bcs :+
	print_str str_error
:
	rts

str_error: .byte "Error!",10,0
.endproc

;-----------------------------------------------------------------------------
; cmd_run
;-----------------------------------------------------------------------------
.proc cmd_run
	; Open file
	jsr set_single_param
	bcs :+
	rts
:	jsr fat32_open
	bcs ok

	; Opening file failed, print error message
	print_str str_file_not_found
	rts
ok:
	; Read code to $800
	set16_val fat32_ptr, $800
	set16_val fat32_size, ($9F00 - $800)
	jsr fat32_read

	; Print number of bytes read
	set16 val32, fat32_size
	stz val32+2
	stz val32+3
	stz padch
	jsr print_val32
	print_str str_bytes_loaded
	jsr fat32_close

	; Call loaded code
	jmp $800

str_file_not_found: .byte "File not found!",10,0
str_bytes_loaded: .byte " bytes loaded",10,0
.endproc

;-----------------------------------------------------------------------------
; cmd_test
;-----------------------------------------------------------------------------
.proc cmd_test
	; Open file
	jsr set_single_param
	bcs :+
	rts
:

	lda #'T'
	jsr putchar

	jsr fat32_create
	bcs :+
	rts
:

	lda #'!'
	jsr putchar

	ldx #0
loop1:	phx

	lda #'.'
	jsr putchar


	lda #' '
loop2:	pha
	jsr fat32_write_byte
	bcc write_failed
	pla
	inc
	; cmp #' ' + 64
	bne loop2

	plx
	inx
	; cpx #64
	bne loop1

done:	jsr fat32_close

	rts

write_failed:
	pla
	plx

	lda #'%'
	jsr putchar

	; jsr fat32_write_byte


	bra done
.endproc

;-----------------------------------------------------------------------------
; cmd_test2
;-----------------------------------------------------------------------------
.proc cmd_test2
	; Open file
	jsr set_single_param
	bcs :+
	rts
:

	lda #'T'
	jsr putchar

	jsr fat32_create
	bcs :+
	rts
:

	ldx #32
:	lda #'.'
	jsr putchar
	phx
	set16_val fat32_ptr, $0
	set16_val fat32_size, $8000
	jsr fat32_write
	plx
	bcc error
	dex
	bne :-

done:	jsr fat32_close
	rts

error:
	lda #'%'
	jsr putchar
	bra done

.endproc

;-----------------------------------------------------------------------------
; cmd_test3
;-----------------------------------------------------------------------------
.proc cmd_test3
	; Open file
	jsr set_single_param
	bcs :+
	rts
:
	lda #'T'
	jsr putchar

	jsr fat32_open
	bcs ok

	; Opening file failed, print error message
	print_str str_file_not_found
	rts
ok:

:	lda #'.'
	jsr putchar
	set16_val fat32_ptr, $4000
	set16_val fat32_size, $4000
	jsr fat32_read

	; php
	; lda fat32_size + 1
	; jsr puthex
	; lda fat32_size + 0
	; jsr puthex
	; plp

	bcs :-

done:
	jsr fat32_close
	rts

str_file_not_found: .byte "File not found!",10,0
.endproc

;-----------------------------------------------------------------------------
; read_sectors_vera
;
; A: number of sectors to read
;-----------------------------------------------------------------------------
.proc read_sectors_vera
	tax

again:
	; Read first 256 bytes from buffer
	ldy #0
l1:	lda sector_buffer+0, y
	sta VERA_DATA0
	lda sector_buffer+1, y
	sta VERA_DATA0
	lda sector_buffer+2, y
	sta VERA_DATA0
	lda sector_buffer+3, y
	sta VERA_DATA0
	lda sector_buffer+4, y
	sta VERA_DATA0
	lda sector_buffer+5, y
	sta VERA_DATA0
	lda sector_buffer+6, y
	sta VERA_DATA0
	lda sector_buffer+7, y
	sta VERA_DATA0

	tya
	clc
	adc #8
	tay
	bne l1

	; Read second 256 bytes from buffer
	ldy #0
l2:	lda sector_buffer+256+0, y
	sta VERA_DATA0
	lda sector_buffer+256+1, y
	sta VERA_DATA0
	lda sector_buffer+256+2, y
	sta VERA_DATA0
	lda sector_buffer+256+3, y
	sta VERA_DATA0
	lda sector_buffer+256+4, y
	sta VERA_DATA0
	lda sector_buffer+256+5, y
	sta VERA_DATA0
	lda sector_buffer+256+6, y
	sta VERA_DATA0
	lda sector_buffer+256+7, y
	sta VERA_DATA0

	tya
	clc
	adc #8
	tay
	bne l2

	phx
	jsr fat32_next_sector
	plx
	bcs :+
	rts
:
	dex
	beq :+
	jmp again
:
	rts
.endproc

;-----------------------------------------------------------------------------
; cmd_movie
;-----------------------------------------------------------------------------
.proc cmd_movie
	; Open file
	jsr set_single_param
	bcs :+
	rts
:
	jsr fat32_open
	bcs ok

	; Opening file failed, print error message
	print_str str_file_not_found
	rts
ok:

	lda VERA_L0_CONFIG
	pha
	lda VERA_L0_TILEBASE
	pha
	lda VERA_L0_HSCROLL_H
	pha
	lda VERA_DC_HSCALE
	pha
	lda VERA_DC_VSCALE
	pha

	lda VERA_DC_VIDEO
	and #($10 ^ $FF)
	sta VERA_DC_VIDEO

	; Switch to 4bpp bitmap mode
	lda #$06
	sta VERA_L0_CONFIG
	stz VERA_L0_TILEBASE
	lda #1			; Set palette offset to grayscale
	sta VERA_L0_HSCROLL_H

	; Display scaling
	lda #64
	sta VERA_DC_HSCALE
	sta VERA_DC_VSCALE

loop:	stz VERA_ADDR_L
	stz VERA_ADDR_M
	lda #$10
	sta VERA_ADDR_H

	lda #75
	jsr read_sectors_vera
	bcc done

	stz VERA_L0_TILEBASE

	stz VERA_ADDR_L
	stz VERA_ADDR_M
	lda #$11
	sta VERA_ADDR_H

	lda #75
	jsr read_sectors_vera
	bcc done

	lda #$80
	sta VERA_L0_TILEBASE

	lda VERA_DC_VIDEO
	ora #$10
	sta VERA_DC_VIDEO

	bra loop

done:
	jsr fat32_close

	lda VERA_DC_VIDEO
	and #($10 ^ $FF)
	sta VERA_DC_VIDEO

	pla
	sta VERA_DC_VSCALE
	pla
	sta VERA_DC_HSCALE
	pla
	sta VERA_L0_HSCROLL_H
	pla
	sta VERA_L0_TILEBASE
	pla
	sta VERA_L0_CONFIG

	jsr clear_screen

	lda VERA_DC_VIDEO
	ora #$10
	sta VERA_DC_VIDEO

	; jsr text_display_init
	rts

str_file_not_found: .byte "File not found!",10,0
.endproc
