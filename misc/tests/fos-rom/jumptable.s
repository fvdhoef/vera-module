;-----------------------------------------------------------------------------
; jumptable.s
; Copyright (C) 2020 Frank van den Hoef
;-----------------------------------------------------------------------------

	.include "cli.inc"
	.include "lib.inc"
	.include "text_display.inc"
	.include "text_input.inc"
        .include "sdcard.inc"
	.include "fat32.inc"
	.include "fat32_util.inc"
        .include "ps2.inc"

        .segment "JUMPTABLE"
jumptable:
        ; PS/2 functions
        jmp ps2_getkey

        ; SD card functions
        jmp sdcard_init
        jmp sdcard_read_sector
        jmp sdcard_write_sector

        ; FAT32 functions
        jmp fat32_init
        jmp fat32_set_context
        jmp fat32_get_free_space
        jmp fat32_open_cwd
        jmp fat32_read_dirent
        jmp fat32_chdir
        jmp fat32_rename
        jmp fat32_delete
        jmp fat32_mkdir
        jmp fat32_rmdir
        jmp fat32_open
        jmp fat32_create
        jmp fat32_close
        jmp fat32_read_byte
        jmp fat32_read
        jmp fat32_write_byte
        jmp fat32_write
        jmp fat32_next_sector
        jmp print_dirent

        ; Text display functions
        jmp clear_screen
        jmp putchar
        jmp putstr
        jmp puthex
        jmp hexdump
        jmp print_val32

        ; Text input functions
        jmp getchar
        jmp to_upper
        jmp to_lower
