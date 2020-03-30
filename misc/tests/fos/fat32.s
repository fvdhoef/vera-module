;-----------------------------------------------------------------------------
; fat32.s
;-----------------------------------------------------------------------------

	.include "fat32.inc"
	.include "lib.inc"
	.include "sdcard.inc"

.struct context
flags           .byte    ; Flags bit 0:in use, 1:dirty
cluster         .dword   ; Current cluster
lba             .dword   ; Sector of current cluster
cluster_sector  .byte    ; Sector index within current cluster
bufptr          .word    ; Pointer within sector_buffer
remaining       .dword   ; Bytes remaining in current file
cwd_cluster     .dword   ; Cluster of current directory
dirent_lba      .dword   ; Sector containing directory entry for this file
dirent_bufptr   .word    ; Offset to start of directory entry 
.endstruct

;-----------------------------------------------------------------------------
; Variables
;-----------------------------------------------------------------------------
	.zeropage
fat32_ptr:              .word 0       ; Used to pass a buffer pointer to read/write functions
fat32_ptr2:             .word 0       ; Used to pass a buffer pointer to read/write functions
bufptr:                 .word 0       ; Points to current offset within sector buffer

	.bss
fat32_cluster:          .dword 0      ; Used to pass cluster to fat32_open_cluster
fat32_size:             .word 0       ; Used to specifiy number of bytes to read/write
fat32_dirent:           .tag dirent   ; Buffer containing decoded directory entry
tmp_buf:                .res 4

; Filesystem parameters
fat32_rootdir_cluster:  .dword 0      ; Cluster of root directory
sectors_per_cluster:    .byte 0       ; Sectors per cluster
cluster_shift:          .byte 0       ; Log2 of sectors_per_cluster
lba_partition:          .dword 0      ; Start sector of FAT32 partition
fat_size:               .dword 0      ; Size in sectors of each FAT table
lba_fat:                .dword 0      ; Start sector of first FAT table
lba_data:               .dword 0      ; Start sector of first data cluster

; Contexts
context_idx:            .byte 0       ; Index of current context
cur_context:            .tag context  ; Current file descriptor state
contexts:               .res 16 * FAT32_CONTEXTS
contexts_end:

sector_lba:             .dword 0
sector_buffer:          .res 512      ; Sector buffer
sector_buffer_end:

filename_buf:		.res 11       ; Used for filename conversion

.if .sizeof(context) * FAT32_CONTEXTS > 256
.error "FAT32_CONTEXTS too high"
.endif

.if .sizeof(context) > 32
.error "Context too big"
.endif

	.code

;-----------------------------------------------------------------------------
; set_sdcard_rw_params
;-----------------------------------------------------------------------------
.proc set_sdcard_rw_params
	; SD card driver expects LBA in big-endian
	lda cur_context + context::lba + 0
	sta sdcard_lba_be + 3
	lda cur_context + context::lba + 1
	sta sdcard_lba_be + 2
	lda cur_context + context::lba + 2
	sta sdcard_lba_be + 1
	lda cur_context + context::lba + 3
	sta sdcard_lba_be + 0

	; Set pointer to buffer
	lda #<sector_buffer
	sta sdcard_bufptr + 0
	lda #>sector_buffer
	sta sdcard_bufptr + 1

	rts
.endproc

;-----------------------------------------------------------------------------
; set_sdcard_rw_params_fat2
;-----------------------------------------------------------------------------
.proc set_sdcard_rw_params_fat2
	; SD card driver expects LBA in big-endian
	clc
	lda cur_context + context::lba + 0
	adc fat_size + 0
	sta sdcard_lba_be + 3
	lda cur_context + context::lba + 1
	adc fat_size + 1
	sta sdcard_lba_be + 2
	lda cur_context + context::lba + 2
	adc fat_size + 2
	sta sdcard_lba_be + 1
	lda cur_context + context::lba + 3
	adc fat_size + 3
	sta sdcard_lba_be + 0

	; Set pointer to buffer
	lda #<sector_buffer
	sta sdcard_bufptr + 0
	lda #>sector_buffer
	sta sdcard_bufptr + 1

	rts
.endproc

;-----------------------------------------------------------------------------
; load_sector_buffer
;-----------------------------------------------------------------------------
.proc load_sector_buffer
	; Check if sector is already loaded
	lda cur_context + context::lba + 0
	cmp sector_lba + 0
	bne do_load
	lda cur_context + context::lba + 1
	cmp sector_lba + 1
	bne do_load
	lda cur_context + context::lba + 2
	cmp sector_lba + 2
	bne do_load
	lda cur_context + context::lba + 3
	cmp sector_lba + 3
	beq done

do_load:
	jsr set_sdcard_rw_params
	jsr sdcard_read_sector
	copy_bytes sector_lba, cur_context + context::lba, 4

done:	sec
	rts
.endproc

;-----------------------------------------------------------------------------
; save_sector_buffer
;-----------------------------------------------------------------------------
.proc save_sector_buffer
	jsr set_sdcard_rw_params
	jmp sdcard_write_sector
.endproc

;-----------------------------------------------------------------------------
; save_fat_sector_buffer
;-----------------------------------------------------------------------------
.proc save_fat_sector_buffer
	; Write first FAT
	jsr set_sdcard_rw_params
	jsr sdcard_write_sector

	; Write second FAT
	jsr set_sdcard_rw_params_fat2
	jmp sdcard_write_sector
.endproc

;-----------------------------------------------------------------------------
; reset_bufptr
;-----------------------------------------------------------------------------
.macro reset_bufptr
	lda #<sector_buffer
	sta bufptr + 0
	lda #>sector_buffer
	sta bufptr + 1
.endmacro

;-----------------------------------------------------------------------------
; fat32_init
;-----------------------------------------------------------------------------
.proc fat32_init
	; Initialize file contexts
	stz context_idx
	clear_bytes cur_context, contexts_end - cur_context

	lda #$FF
	sta sector_lba + 0
	sta sector_lba + 1
	sta sector_lba + 2
	sta sector_lba + 3

	; Initialize SD card
	jsr sdcard_init
	bcs :+
	jmp error
:
	; Read partition table
	stz sdcard_lba_be + 0
	stz sdcard_lba_be + 1
	stz sdcard_lba_be + 2
	stz sdcard_lba_be + 3
	lda #<sector_buffer
	sta sdcard_bufptr
	lda #>sector_buffer
	sta sdcard_bufptr + 1
	jsr sdcard_read_sector
	bcs :+
	jmp error
:
	; Check partition type of first partition
	lda sector_buffer + $1BE + 4
	cmp #$0B
	beq :+
	cmp #$0C
	beq :+
	jmp error
:
	; Get LBA of partition of first partition
	copy_bytes lba_partition, sector_buffer + $1BE + 8, 4

	; Read first sector of FAT32 partition
	copy_bytes cur_context + context::lba, lba_partition, 4
	jsr load_sector_buffer
	bcs :+
	jmp error
:
	; Some sanity checks
	lda sector_buffer + 510 ; Check signature
	cmp #$55
	bne invalid
	lda sector_buffer + 511
	cmp #$AA
	bne invalid
	lda sector_buffer + 16 ; # of FATs should be 2
	cmp #2
	bne invalid
	lda sector_buffer + 17 ; Root entry count = 0 for FAT32
	bne invalid
	lda sector_buffer + 18
	bne invalid
	bra valid
invalid:
	jmp error
valid:
	; Calculate shift amount based on sectors per cluster field
	lda sector_buffer + 13
	sta sectors_per_cluster
	bne :+
	jmp error
:	stz cluster_shift
shift_loop:
	lsr
	beq :+
	inc cluster_shift
	bra shift_loop
:
	; Fat size in sectors
	copy_bytes fat_size, sector_buffer + 36, 4

	; Root cluster
	copy_bytes fat32_rootdir_cluster, sector_buffer + 44, 4

	; Calculate LBA of first FAT
	add32_16 lba_fat, lba_partition, sector_buffer + 14

	; Calculate LBA of first data sector
	add32 lba_data, lba_fat, fat_size
	add32 lba_data, lba_data, fat_size

	sec
	rts

error:	clc
	rts
.endproc

;-----------------------------------------------------------------------------
; fat32_set_context
;
; context index in A
;-----------------------------------------------------------------------------
.proc fat32_set_context
	; Already selected?
	cmp context_idx
	beq done

	; Valid context index?
	cmp #FAT32_CONTEXTS
	bcs error

	; Save new context index
	pha

	; Put zero page variables in current context
	lda bufptr + 0
	sta cur_context + context::bufptr + 0
	lda bufptr + 1
	sta cur_context + context::bufptr + 1

	; Copy current context back
	lda context_idx   ; X=A*32
	asl
	asl
	asl
	asl
	asl
	tax

	ldy #0
:	lda cur_context, y
	sta contexts, x
	inx
	iny
	cpy #(.sizeof(context))
	bne :-

	; Copy new context to current
	pla              ; Get new context idx
	sta context_idx  ; X=A*16
	asl
	asl
	asl
	asl
	tax

	ldy #0
:	lda contexts, x
	sta cur_context, y
	inx
	iny
	cpy #(.sizeof(context))
	bne :-

	; Restore zero page variables from current context
	lda cur_context + context::bufptr + 0
	sta bufptr + 0
	lda cur_context + context::bufptr + 1
	sta bufptr + 1

	; Reload sector
	lda cur_context + context::flags
	and #1
	beq reload_done
	jsr load_sector_buffer
reload_done:

done:	sec
	rts
error:	clc
	rts
.endproc

;-----------------------------------------------------------------------------
; calc_cluster_lba
;-----------------------------------------------------------------------------
.proc calc_cluster_lba
	; lba = lba_data + ((cluster - 2) << cluster_shift)
	sub32_val cur_context + context::lba, cur_context + context::cluster, 2
	ldy cluster_shift
	beq shift_done
:	asl cur_context + context::lba + 0
	rol cur_context + context::lba + 1
	rol cur_context + context::lba + 2
	rol cur_context + context::lba + 3
	dey
	bne :-
shift_done:

	add32 cur_context + context::lba, cur_context + context::lba, lba_data
	stz cur_context + context::cluster_sector
	rts
.endproc

;-----------------------------------------------------------------------------
; load_fat_sector_for_cluster
;
; Load sector that hold cluster entry for cur_context.cluster
; On return bufptr points to cluster entry in sector_buffer.
;
; C=1 on success, C=0 on failure
;-----------------------------------------------------------------------------
.proc load_fat_sector_for_cluster
	; Calculate sector where cluster entry is located

	; lba = lba_fat + (cluster / 128)
	lda cur_context + context::cluster + 1
	sta cur_context + context::lba + 0
	lda cur_context + context::cluster + 2
	sta cur_context + context::lba + 1
	lda cur_context + context::cluster + 3
	sta cur_context + context::lba + 2
	stz cur_context + context::lba + 3
	lda cur_context + context::cluster + 0
	asl	; upper bit in C
	rol cur_context + context::lba + 0
	rol cur_context + context::lba + 1
	rol cur_context + context::lba + 2
	rol cur_context + context::lba + 3
	add32 cur_context + context::lba, cur_context + context::lba, lba_fat

	; Read FAT sector
	jsr load_sector_buffer
	bcs :+
	rts	; Failure
:
	; bufptr = sector_buffer + (cluster & 127) * 4
	lda cur_context + context::cluster
	asl
	asl
	sta bufptr + 0
	lda #0
	bcc :+
	lda #1
:	sta bufptr + 1

	clc
	lda bufptr + 0
	adc #<sector_buffer
	sta bufptr + 0
	lda bufptr + 1
	adc #>sector_buffer
	sta bufptr + 1

	; Success
	sec
	rts
.endproc

;-----------------------------------------------------------------------------
; next_cluster
;-----------------------------------------------------------------------------
.proc next_cluster
	; Load correct FAT sector
	jsr load_fat_sector_for_cluster
	bcc error

	; Copy next cluster from FAT
	ldy #0
:	lda (bufptr), y
	sta cur_context + context::cluster, y
	iny
	cpy #4
	bne :-

	; Check if this is the end of cluster chain (entry >= 0x0FFFFFF8)
	lda cur_context + context::cluster + 3
	cmp #$0F
	bcc :+
	lda cur_context + context::cluster + 2
	cmp #$FF
	bne :+
	lda cur_context + context::cluster + 1
	cmp #$FF
	bne :+
	lda cur_context + context::cluster + 0
	cmp #$F8
	bcs error
:
	sec
	rts

error:	clc
	rts
.endproc

;-----------------------------------------------------------------------------
; validate_char
;-----------------------------------------------------------------------------
.proc validate_char
	; Allowed: 33, 35-41, 45, 48-57, 64-90, 94-96, 123, 125, 126
	cmp #33
	beq ok
	cmp #35
	bcc not_ok
	cmp #41+1
	bcc ok
	cmp #45
	beq ok
	cmp #48
	bcc not_ok
	cmp #57+1
	bcc ok
	cmp #64
	bcc not_ok
	cmp #90+1
	bcc ok
	cmp #94
	bcc not_ok
	cmp #96
	bcc ok
	cmp #123
	beq ok
	cmp #125
	beq ok
	cmp #126
	beq ok
not_ok:	clc
	rts
ok:	sec
	rts
.endproc

.if 0
;-----------------------------------------------------------------------------
; validate_filename
;-----------------------------------------------------------------------------
.proc validate_filename
	; Disallow empty string or string starting with '.'
	lda (fat32_ptr)
	beq not_ok
	cmp #'.'
	beq not_ok

	; Check name part
	ldy #0
:	lda (fat32_ptr), y
	beq done
	cmp #'.'
	beq extension
	jsr validate_char
	bcc not_ok
	iny
	cpy #8
	bne :-
	bra done

extension:
	iny	; Skip '.'

	; Check extension part
	ldx #3
:	lda (fat32_ptr), y
	beq done
	jsr validate_char
	bcc not_ok
	iny
	dex
	bne :-

done:	; Check for end of string
	lda (fat32_ptr), y
	bne not_ok
	sec
	rts

not_ok:	clc
	rts
.endproc
.endif

;-----------------------------------------------------------------------------
; convert_filename
;-----------------------------------------------------------------------------
.proc convert_filename
	; Disallow empty string or string starting with '.'
	lda (fat32_ptr)
	beq not_ok
	cmp #'.'
	beq not_ok

	; Copy name part
	ldy #0
	ldx #0
loop1:	lda (fat32_ptr), y
	beq name_pad
	cmp #'.'
	beq name_pad
	jsr validate_char
	bcc not_ok
	sta filename_buf, x
	inx
	iny
	cpy #8
	bne loop1

	; Pad name with spaces
name_pad:
	lda #' '
loop2:	cpx #8
	beq name_pad_done
	sta filename_buf, x
	inx
	bra loop2
name_pad_done:

	; Check next character
	lda (fat32_ptr), y
	beq ext_pad
	cmp #'.'
	beq ext
	bra not_ok

	; Copy extension part
ext:	iny	; Skip '.'

loop3:	lda (fat32_ptr), y
	beq ext_pad
	jsr validate_char
	bcc not_ok
	sta filename_buf, x
	inx
	iny
	cpx #11
	bne loop3

	; Check for end of string
	lda (fat32_ptr), y
	bne not_ok

	; Pad extension with spaces
ext_pad:
	lda #' '
loop4:	cpx #11
	beq ext_pad_done
	sta filename_buf, x
	inx
	bra loop4
ext_pad_done:

	; Done
	sec
	rts

not_ok:	clc
	rts
.endproc

;-----------------------------------------------------------------------------
; fat32_open_cluster
;-----------------------------------------------------------------------------
.proc fat32_open_cluster
	; Check if cluster == 0 -> modify into root dir
	lda fat32_cluster + 0
	ora fat32_cluster + 1
	ora fat32_cluster + 2
	ora fat32_cluster + 3
	beq rootdir
	copy_bytes cur_context + context::cluster, fat32_cluster, 4
	bra readsector

rootdir:
	copy_bytes cur_context + context::cluster, fat32_rootdir_cluster, 4

readsector:
	; Read first sector of cluster
	jsr calc_cluster_lba
	jsr load_sector_buffer

	; Reset buffer pointer
	reset_bufptr

	; Set buffer as in-use
	lda #1
	sta cur_context + context::flags

done:	sec
	rts

error:	clc
	rts
.endproc

;-----------------------------------------------------------------------------
; fat32_next_sector
;-----------------------------------------------------------------------------
.proc fat32_next_sector
	inc cur_context + context::cluster_sector
	lda cur_context + context::cluster_sector
	cmp sectors_per_cluster
	beq end_of_cluster

	inc32 cur_context + context::lba

read_sector:
	jsr load_sector_buffer
	reset_bufptr

done:	sec
	rts

end_of_cluster:
	jsr next_cluster
	bcc error
	jsr calc_cluster_lba
	bra read_sector

error:	clc
	rts
.endproc

;-----------------------------------------------------------------------------
; fat32_read
;
; Set destination address in fat32_ptr
; Set amount to copy in fat32_size
;-----------------------------------------------------------------------------
.proc fat32_read
next:
	; At end of buffer?
	lda bufptr + 0
	cmp #<sector_buffer_end
	bne :+
	lda bufptr + 1
	cmp #>sector_buffer_end
	bne :+
	jsr fat32_next_sector
	bcc error
:
	; Copy byte from source to destination pointer
	lda (bufptr)
	sta (fat32_ptr)
	inc16 fat32_ptr
	inc16 bufptr

	; Decrease count and check if done
	dec16 fat32_size
	lda fat32_size + 0
	bne next
	lda fat32_size + 1
	bne next

done:	sec
	rts

error:	clc
	rts
.endproc

;-----------------------------------------------------------------------------
; fat32_get_byte
;-----------------------------------------------------------------------------
.proc fat32_get_byte
next:
	; Bytes remaining?
	lda cur_context + context::remaining + 0
	ora cur_context + context::remaining + 1
	ora cur_context + context::remaining + 2
	ora cur_context + context::remaining + 3
	bne :+
	clc
	rts
:
	; At end of buffer?
	lda bufptr + 0
	cmp #<sector_buffer_end
	bne :+
	lda bufptr + 1
	cmp #>sector_buffer_end
	bne :+
	jsr fat32_next_sector
	bcs :+
	clc	; Indicate error
	rts
:
	; Decrement bytes remaining
	dec32 cur_context + context::remaining

	; Get byte from buffer
	lda (bufptr)
	inc16 bufptr

	sec	; Indicate success
	rts
.endproc

;-----------------------------------------------------------------------------
; fat32_read_dirent
;-----------------------------------------------------------------------------
.proc fat32_read_dirent
read_entry:
	; At end of buffer?
	lda bufptr + 0
	cmp #<sector_buffer_end
	bne :+
	lda bufptr + 1
	cmp #>sector_buffer_end
	bne :+
	jsr fat32_next_sector
	bcs :+
	clc     ; Indicate error
	rts
:
	; Skip volume label entries
	ldy #11
	lda (bufptr), y
	sta fat32_dirent + dirent::attributes
	and #8
	beq :+
	jmp next_entry
:
	; Last entry?
	ldy #0
	lda (bufptr), y
	bne :+
	jmp error
:
	; Skip empty entries
	cmp #$E5
	bne :+
	jmp next_entry
:
	; Copy first part of file name
	ldy #0
:	lda (bufptr), y
	cmp #' '
	beq skip_spaces
	sta fat32_dirent + dirent::name, y
	iny
	cpy #8
	bne :-

	; Skip any following spaces
skip_spaces:
	tya
	tax
skip_space_loop:
	cpy #8
	beq :+
	lda (bufptr), y
	iny
	cmp #' '
	beq skip_space_loop
:
	; If extension starts with a space, we're done
	lda (bufptr), y
	cmp #' '
	beq name_done

	; Add dot to output
	lda #'.'
	sta fat32_dirent + dirent::name, x
	inx

	; Copy extension part of file name
:	lda (bufptr), y
	cmp #' '
	beq name_done
	sta fat32_dirent + dirent::name, x
	iny
	inx
	cpy #11
	bne :-

name_done:
	; Add zero-termination to output
	lda #0
	sta fat32_dirent + dirent::name, x

	; Copy file size
	ldy #28
	ldx #0
:	lda (bufptr), y
	sta fat32_dirent + dirent::size, x
	iny
	inx
	cpx #4
	bne :-

	; Copy cluster
	ldy #26
	lda (bufptr), y
	sta fat32_dirent + dirent::cluster + 0
	iny
	lda (bufptr), y
	sta fat32_dirent + dirent::cluster + 1
	ldy #20
	lda (bufptr), y
	sta fat32_dirent + dirent::cluster + 2
	iny
	lda (bufptr), y
	sta fat32_dirent + dirent::cluster + 3

	; Save lba + bufptr
	copy_bytes cur_context + context::dirent_lba,    cur_context + context::lba, 4
	copy_bytes cur_context + context::dirent_bufptr, bufptr, 2

	; Increment buffer pointer to next entry
	clc
	lda bufptr + 0
	adc #32
	sta bufptr + 0
	lda bufptr + 1
	adc #0
	sta bufptr + 1

	sec
	rts

next_entry:
	clc
	lda bufptr + 0
	adc #32
	sta bufptr + 0
	lda bufptr + 1
	adc #0
	sta bufptr + 1
	jmp read_entry

error:	clc
	rts
.endproc

;-----------------------------------------------------------------------------
; fat32_open_cwd
;
; Open current working directory
;-----------------------------------------------------------------------------
.proc fat32_open_cwd
	; Open current directory
	copy_bytes fat32_cluster, cur_context + context::cwd_cluster, 4
	jmp fat32_open_cluster
.endproc

;-----------------------------------------------------------------------------
; fat32_find_dirent
;
; Find directory entry with name specified in string pointed to by fat32_ptr
;-----------------------------------------------------------------------------
.proc fat32_find_dirent
	jsr fat32_open_cwd
	bcc error

next:	jsr fat32_read_dirent
	bcc error

	ldy #0
:	lda fat32_dirent + dirent::name, y
	beq match
	cmp (fat32_ptr), y
	bne next
	iny
	bra :-

match:	; Search string also at end?
	lda (fat32_ptr), y
	bne next

	sec
	rts

error:
	clc
	rts
.endproc

;-----------------------------------------------------------------------------
; fat32_find_file
;
; Same as fat32_find_dirent, but with file type check
;-----------------------------------------------------------------------------
.proc fat32_find_file
	; Find directory entry
	jsr fat32_find_dirent
	bcs :+
	rts
:
	; Check if this is a file
	lda fat32_dirent + dirent::attributes
	bit #$10
	beq :+
	clc
	rts
:	
	; Success
	sec
	rts
.endproc

;-----------------------------------------------------------------------------
; fat32_find_dir
;
; Same as fat32_find_dirent, but with directory type check
;-----------------------------------------------------------------------------
.proc fat32_find_dir
	; Find directory entry
	jsr fat32_find_dirent
	bcs :+
	rts
:
	; Check if this is a directory
	lda fat32_dirent + dirent::attributes
	bit #$10
	bne :+
	clc
	rts
:
	; Success
	sec
	rts
.endproc

;-----------------------------------------------------------------------------
; fat32_open_file
;
; Open file specified in string pointed to by fat32_ptr
;-----------------------------------------------------------------------------
.proc fat32_open_file
	; Find file
	jsr fat32_find_file
	bcs :+
	rts
:
	; Open file
	copy_bytes cur_context + context::remaining, fat32_dirent + dirent::size, 4
	copy_bytes fat32_cluster, fat32_dirent + dirent::cluster, 4
	jmp fat32_open_cluster
.endproc

;-----------------------------------------------------------------------------
; fat32_chdir
;-----------------------------------------------------------------------------
.proc fat32_chdir
	; Find directory
	jsr fat32_find_dir
	bcs :+
	rts
:
	; Set as current directory
	copy_bytes cur_context + context::cwd_cluster, fat32_dirent + dirent::cluster, 4

	sec
	rts
.endproc

;-----------------------------------------------------------------------------
; fat32_rename
;-----------------------------------------------------------------------------
.proc fat32_rename
	; Save first argument
	copy_bytes tmp_buf, fat32_ptr, 2

	; Make sure target name doesn't exist
	copy_bytes fat32_ptr, fat32_ptr2, 2
	jsr fat32_find_dirent
	bcc :+
	clc	; Error, file exists
	rts
:
	; Convert target filename into directory entry format
	copy_bytes fat32_ptr, fat32_ptr2, 2
	jsr convert_filename
	bcs :+
	rts
:
	; Find file to rename
	copy_bytes fat32_ptr, tmp_buf, 2
	jsr fat32_find_dirent
	bcs :+
	rts
:
	; Copy new filename into sector buffer
	copy_bytes bufptr, cur_context + context::dirent_bufptr, 2
	ldy #0
:	lda filename_buf, y
	sta (bufptr), y
	iny
	cpy #11
	bne :-

	; Write sector buffer to disk
	jmp save_sector_buffer
.endproc

;-----------------------------------------------------------------------------
; unlink_cluster_chain
;-----------------------------------------------------------------------------
.proc unlink_cluster_chain
next:	jsr next_cluster
	php

	; Set entry as free
	lda #0
	ldy #0
	sta (bufptr), y
	iny
	sta (bufptr), y
	iny
	sta (bufptr), y
	iny
	sta (bufptr), y

	jsr save_fat_sector_buffer
	bcc error

	plp
	bcs next

	sec
	rts

error:
	clc
	rts
.endproc

;-----------------------------------------------------------------------------
; fat32_delete
;-----------------------------------------------------------------------------
.proc fat32_delete
	; Find file
	jsr fat32_find_file
	bcs :+
	rts
:
	; Mark file as deleted
	copy_bytes bufptr, cur_context + context::dirent_bufptr, 2
	lda #$E5
	sta (bufptr)

	; Write sector buffer to disk
	jsr save_sector_buffer
	bcs :+
	rts
:
	; Unlink cluster chain
	copy_bytes cur_context + context::cluster, fat32_dirent + dirent::cluster, 4
	jmp unlink_cluster_chain
.endproc
