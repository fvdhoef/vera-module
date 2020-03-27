;-----------------------------------------------------------------------------
; fat32.s
;-----------------------------------------------------------------------------

	.include "fat32.inc"
	.include "lib.inc"
	.include "sdcard.inc"

.struct context
flags          .byte       ; Flags bit 0:in use, 1:dirty
cluster        .dword      ; Current cluster
lba            .dword      ; Sector of current cluster
cluster_sector .byte       ; Sector index within current cluster
bufptr         .word       ; Pointer within sector_buffer
.endstruct

;-----------------------------------------------------------------------------
; Variables
;-----------------------------------------------------------------------------
	.zeropage
fat32_ptr:              .word 0       ; Used to pass a buffer pointer to read/write functions
bufptr:                 .word 0       ; Points to current offset within sector buffer

	.bss
fat32_cluster:          .dword 0      ; Used to pass cluster to fat32_open_cluster
fat32_cnt:              .word 0       ; Used to specifiy number of bytes to read/write
fat32_dirent:           .tag dirent   ; Buffer containing decoded directory entry

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

sector_buffer:          .res 512
sector_buffer_end:

.if .sizeof(context) * FAT32_CONTEXTS > 256
.error "FAT32_CONTEXTS too high"
.endif

.if .sizeof(context) > 16
.error "Context too big"
.endif

	.code

;-----------------------------------------------------------------------------
; read_lba
;-----------------------------------------------------------------------------
.macro read_lba lba, buffer, error
	; SD card driver expects LBA in big-endian
	lda lba + 0
	sta sdcard_lba_be + 3
	lda lba + 1
	sta sdcard_lba_be + 2
	lda lba + 2
	sta sdcard_lba_be + 1
	lda lba + 3
	sta sdcard_lba_be + 0

	; Set pointer to buffer
	lda #<buffer
	sta sdcard_bufptr + 0
	lda #>buffer
	sta sdcard_bufptr + 1

	; Read the sector
	jsr sdcard_read_sector
	bcs :+
	jmp error
:
.endmacro

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
	ldy #0
:	lda sector_buffer + $1BE + 8, y
	sta lba_partition, y
	iny
	cpy #4
	bne :-

	; Read first sector of FAT32 partition
	read_lba lba_partition, sector_buffer, error

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
	lda context_idx   ; X=A*16
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
	read_lba cur_context + context::lba, sector_buffer, error
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
; next_cluster
;-----------------------------------------------------------------------------
.proc next_cluster
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

	; read FAT sector
	read_lba cur_context + context::lba, sector_buffer, error

	lda cur_context + context::cluster
	asl
	asl
	tay
	bcs upper_half	; In first or second 256 byte part of sector?

	; Copy FAT entry into cur_context + context::cluster
	ldx #0
:	lda sector_buffer, y
	sta cur_context + context::cluster, x
	iny
	inx
	cpx #4
	bne :-

	bra done

upper_half:
	; Copy FAT entry into cur_context + context::cluster
	ldx #0
:	lda sector_buffer + 256, y
	sta cur_context + context::cluster, x
	iny
	inx
	cpx #4
	bne :-

done:
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
; fat32_open_cluster
;-----------------------------------------------------------------------------
.proc fat32_open_cluster
	; Read first sector of cluster
	copy_bytes cur_context + context::cluster, fat32_cluster, 4
	jsr calc_cluster_lba
	read_lba cur_context + context::lba, sector_buffer, error

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
	read_lba cur_context + context::lba, sector_buffer, error
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
; Set amount to copy in fat32_cnt
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
	dec16 fat32_cnt
	lda fat32_cnt + 0
	bne next
	lda fat32_cnt + 1
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
	beq next_entry

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
; fat32_find_file
;
; Find file specified in zero-terminated string pointer to by fat32_ptr
;-----------------------------------------------------------------------------
.proc fat32_find_file
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
