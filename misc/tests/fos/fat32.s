;-----------------------------------------------------------------------------
; fat32.s
; Copyright (C) 2020 Frank van den Hoef
;
; TODO:
; - implement fat32_mkdir, fat32_rmdir, fat32_seek
; - improve read/write performance
;-----------------------------------------------------------------------------
	.include "text_display.inc"

	.include "fat32.inc"
	.include "lib.inc"
	.include "sdcard.inc"

CONTEXT_SIZE = 32

FLAG_IN_USE = 1<<0  ; Context in use
FLAG_DIRTY  = 1<<1  ; Buffer is dirty
FLAG_DIRENT = 1<<2  ; Directory entry needs to be updated on close

.struct context
flags           .byte    ; Flag bits
cluster         .dword   ; Current cluster
lba             .dword   ; Sector of current cluster
cluster_sector  .byte    ; Sector index within current cluster
bufptr          .word    ; Pointer within sector_buffer
file_size       .dword   ; Size of current file
file_offset     .dword   ; Offset in current file
dirent_lba      .dword   ; Sector containing directory entry for this file
dirent_bufptr   .word    ; Offset to start of directory entry 
.endstruct

;-----------------------------------------------------------------------------
; API variables
;-----------------------------------------------------------------------------
	.zeropage
fat32_ptr:           .word 0       ; Buffer pointer to various functions
fat32_ptr2:          .word 0       ; Buffer pointer to various functions

	.bss
fat32_size:          .word 0       ; Used for fat32_get_free_space result
fat32_dirent:        .tag dirent   ; Buffer containing decoded directory entry

;-----------------------------------------------------------------------------
; Variables
;-----------------------------------------------------------------------------
	.zeropage
bufptr:              .word 0       ; Points to current offset within sector buffer

	.bss
; Static filesystem parameters
rootdir_cluster:     .dword 0      ; Cluster of root directory
sectors_per_cluster: .byte 0       ; Sectors per cluster
cluster_shift:       .byte 0       ; Log2 of sectors_per_cluster
lba_partition:       .dword 0      ; Start sector of FAT32 partition
fat_size:            .dword 0      ; Size in sectors of each FAT table
lba_fat:             .dword 0      ; Start sector of first FAT table
lba_data:            .dword 0      ; Start sector of first data cluster
cluster_count:       .dword 0      ; Total number of cluster on volume
lba_fsinfo:          .dword 0      ; Sector number of FS info

; Variables
cwd_cluster:         .dword 0      ; Cluster of current directory
free_clusters:       .dword 0      ; Number of free clusters (from FS info)
free_cluster:        .dword 0      ; Cluster to start search for free clusters, also holds result of find_free_cluster
filename_buf:        .res 11       ; Used for filename conversion

; Temp buffers
tmp_buf:             .res 4        ; Used by save_sector_buffer, fat32_rename
next_sector_arg:     .byte 0       ; Used by next_sector to store argument
tmp_bufptr:          .word 0       ; Used by next_sector
tmp_sector_lba:      .dword 0      ; Used by next_sector

; Contexts
context_idx:         .byte 0       ; Index of current context
cur_context:         .tag context  ; Current file descriptor state
contexts:            .res CONTEXT_SIZE * FAT32_CONTEXTS
contexts_end:

.if CONTEXT_SIZE * FAT32_CONTEXTS > 256
.error "FAT32_CONTEXTS too high"
.endif

.if .sizeof(context) > CONTEXT_SIZE
.error "Context too big"
.endif

	.code

;-----------------------------------------------------------------------------
; sync_sector_buffer
;-----------------------------------------------------------------------------
.proc sync_sector_buffer
	; Write back sector buffer if dirty
	lda cur_context + context::flags
	bit #FLAG_DIRTY
	beq done
	jmp save_sector_buffer

done:	sec
	rts
.endproc

;-----------------------------------------------------------------------------
; load_sector_buffer
;-----------------------------------------------------------------------------
.proc load_sector_buffer
	; Check if sector is already loaded
	cmp32 cur_context + context::lba, sector_lba, do_load
	sec
	rts

do_load:
	jsr sync_sector_buffer
	set32 sector_lba, cur_context + context::lba
	jmp sdcard_read_sector
.endproc

;-----------------------------------------------------------------------------
; save_sector_buffer
;-----------------------------------------------------------------------------
.proc save_sector_buffer
	; Determine if this is FAT area write (sector_lba - lba_fat < fat_size)
	sub32 tmp_buf, sector_lba, lba_fat
	lda tmp_buf + 2
	ora tmp_buf + 3
	bne normal
	sec
	lda tmp_buf + 0
	sbc fat_size + 0
	lda tmp_buf + 1
	sbc fat_size + 1
	bcs normal

	; Write second FAT
	set32 tmp_buf, sector_lba
	add32 sector_lba, sector_lba, fat_size
	jsr sdcard_write_sector
	php
	set32 sector_lba, tmp_buf
	plp
	bcs :+
	rts
:
normal:	jsr sdcard_write_sector
	bcs :+
	rts
:
	; Clear dirty bit
	lda cur_context + context::flags
	and #(FLAG_DIRTY ^ $FF)
	sta cur_context + context::flags

	sec
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
:	shl32 cur_context + context::lba
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
	add16_val bufptr, bufptr, sector_buffer

	; Success
	sec
	rts
.endproc

;-----------------------------------------------------------------------------
; is_end_of_cluster_chain 
;-----------------------------------------------------------------------------
.proc is_end_of_cluster_chain
	; Check if this is the end of cluster chain (entry >= 0x0FFFFFF8)
	lda cur_context + context::cluster + 3
	and #$0F	; Ignore upper 4 bits
	cmp #$0F
	bne no
	lda cur_context + context::cluster + 2
	cmp #$FF
	bne no
	lda cur_context + context::cluster + 1
	cmp #$FF
	bne no
	lda cur_context + context::cluster + 0
	cmp #$F8
	bcs yes
no:	clc
yes:	rts
.endproc

;-----------------------------------------------------------------------------
; next_cluster
;-----------------------------------------------------------------------------
.proc next_cluster
	; End of cluster chain?
	jsr is_end_of_cluster_chain
	bcs error

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

	sec
	rts

error:	clc
	rts
.endproc

;-----------------------------------------------------------------------------
; unlink_cluster_chain
;-----------------------------------------------------------------------------
.proc unlink_cluster_chain
	; Don't unlink cluster 0
	lda cur_context + context::cluster + 0
	ora cur_context + context::cluster + 1
	ora cur_context + context::cluster + 2
	ora cur_context + context::cluster + 3
	bne next
	sec
	rts

next:	jsr next_cluster
	bcc done

	; Set this cluster as new search start point if lower than current start point
	ldy #3
	lda free_cluster + 3
	cmp (bufptr), y
	bcc :+
	dey
	lda free_cluster + 2
	cmp (bufptr), y
	bcc :+
	dey
	lda free_cluster + 1
	cmp (bufptr), y
	bcc :+
	dey
	lda free_cluster + 0
	cmp (bufptr), y
	bcc :+
	beq :+

	ldy #0
l1:	lda (bufptr), y
	sta free_cluster, y
	iny
	cpy #4
	bne l1
:
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

	; Increment free clusters
	inc32 free_clusters

	; Set sector as dirty
	lda cur_context + context::flags
	ora #FLAG_DIRTY
	sta cur_context + context::flags

	bra next

	; Make sure dirty sectors are written to disk
done:	jsr sync_sector_buffer
	jmp update_fs_info
.endproc

;-----------------------------------------------------------------------------
; find_free_cluster
;-----------------------------------------------------------------------------
.proc find_free_cluster
	; Start search at free_cluster
	set32 cur_context + context::cluster, free_cluster
	jsr load_fat_sector_for_cluster

next:
	; Check for free entry
	ldy #3
	lda (bufptr), y
	and #$0F	; Ignore upper 4 bits of 32-bit entry
	dey
	ora (bufptr), y
	dey
	ora (bufptr), y
	dey
	ora (bufptr), y
	bne not_free

	; Return found free cluster
	set32 free_cluster, cur_context + context::cluster
	sec
	rts

not_free:
	; bufptr += 4
	add16_val bufptr, bufptr, 4

	; cluster += 1
	inc32 cur_context + context::cluster

	; Check if at end of FAT table
	cmp32 cur_context + context::cluster, cluster_count, :+
	clc
	rts
:
	; Load next FAT sector if at end of buffer
	cmp16_val bufptr, sector_buffer_end, next
	inc32 cur_context + context::lba
	jsr load_sector_buffer
	bcs :+
	rts
:	set16_val bufptr, sector_buffer
	jmp next
.endproc

;-----------------------------------------------------------------------------
; update_fs_info
;-----------------------------------------------------------------------------
.proc update_fs_info
	; Load FS info sector
	set32 cur_context + context::lba, lba_fsinfo
	jsr load_sector_buffer
	bcs :+
	rts
:
	; Get number of free clusters
	set32 sector_buffer + 488, free_clusters

	; Save sector
	jmp save_sector_buffer
.endproc

;-----------------------------------------------------------------------------
; allocate_cluster
;-----------------------------------------------------------------------------
.proc allocate_cluster
	; Find free entry
	jsr find_free_cluster
	bcs :+
	rts
:
	; Set cluster as end-of-chain
	ldy #0
	lda #$FF
	sta (bufptr), y
	iny
	sta (bufptr), y
	iny
	sta (bufptr), y
	iny
	lda (bufptr), y
	ora #$0F	; Preserve upper 4 bits
	sta (bufptr), y

	; Save FAT sector
	jsr save_sector_buffer
	bcs :+
	rts
:
	; Decrement free clusters and update FS info
	dec32 free_clusters
	jmp update_fs_info
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
; open_cluster
;-----------------------------------------------------------------------------
.proc open_cluster
	; Check if cluster == 0 -> modify into root dir
	lda cur_context + context::cluster + 0
	ora cur_context + context::cluster + 1
	ora cur_context + context::cluster + 2
	ora cur_context + context::cluster + 3
	bne readsector
	set32 cur_context + context::cluster, rootdir_cluster

readsector:
	; Read first sector of cluster
	jsr calc_cluster_lba
	jsr load_sector_buffer
	bcc exit

	; Reset buffer pointer
	set16_val bufptr, sector_buffer

done:	sec
exit:	rts
.endproc

;-----------------------------------------------------------------------------
; next_sector
; A: bit0 - allocate cluster if at end of cluster chain
;    bit1 - clear allocated cluster
;-----------------------------------------------------------------------------
.proc next_sector
	; Save argument
	sta next_sector_arg

	; Last sector of cluster?
	lda cur_context + context::cluster_sector
	inc
	cmp sectors_per_cluster
	beq end_of_cluster
	sta cur_context + context::cluster_sector

	; Load next sector
	inc32 cur_context + context::lba
read_sector:
	jsr load_sector_buffer
	bcc error
	set16_val bufptr, sector_buffer
	sec
	rts

end_of_cluster:
	jsr next_cluster
	bcc error
	jsr is_end_of_cluster_chain
	bcs end_of_chain
read_cluster:
	jsr calc_cluster_lba
	bra read_sector

end_of_chain:
	; Request to allocate new cluster?
	lda next_sector_arg
	bit #$01
	beq error

	; Save location of cluster entry in FAT
	set16 tmp_bufptr, bufptr
	set32 tmp_sector_lba, sector_lba

	; Allocate a new cluster
	jsr allocate_cluster
	bcc error

	; Load back the cluster sector
	set32 cur_context + context::lba, tmp_sector_lba
	jsr load_sector_buffer
	bcs :+
error:	clc
	rts
:
	set16 bufptr, tmp_bufptr
	
	; Write allocated cluster number in FAT
	ldy #0
l1:	lda free_cluster, y
	sta (bufptr), y
	iny
	cpy #4
	bne l1

	; Save FAT sector
	jsr save_sector_buffer
	bcc error

	; Request to clear new cluster?
	lda next_sector_arg
	bit #$02
	beq wrdone

	; Fill sector buffer with 0
	lda #0
	ldy #0
l2:	sta sector_buffer, y
	sta sector_buffer + 256, y
	iny
	bne l2

	; Write sectors
	jsr calc_cluster_lba
l3:	set32 sector_lba, cur_context + context::lba
	jsr sdcard_write_sector
	bcc error
	lda cur_context + context::cluster_sector
	inc
	cmp sectors_per_cluster
	beq wrdone
	sta cur_context + context::cluster_sector
	inc32 cur_context + context::lba
	bra l3

wrdone:	; Retry
	set32 cur_context + context::cluster, free_cluster
	jmp read_cluster
.endproc

;-----------------------------------------------------------------------------
; open_cwd
;-----------------------------------------------------------------------------
.proc open_cwd
	; Open current directory
	set32 cur_context + context::cluster, cwd_cluster
	jmp open_cluster
.endproc

;-----------------------------------------------------------------------------
; find_dirent
;
; Find directory entry with name specified in string pointed to by fat32_ptr
;-----------------------------------------------------------------------------
.proc find_dirent
	jsr open_cwd
	bcc error

next:	; Read entry
	jsr fat32_read_dirent
	bcc error

	; Check if name matches
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

	; Found
	sec
	rts

error:	clc
	rts
.endproc

;-----------------------------------------------------------------------------
; find_file
;
; Same as find_dirent, but with file type check
;-----------------------------------------------------------------------------
.proc find_file
	; Find directory entry
	jsr find_dirent
	bcc error

	; Check if this is a file
	lda fat32_dirent + dirent::attributes
	bit #$10
	bne error

	; Success
	sec
	rts

error:	clc
	rts
.endproc

;-----------------------------------------------------------------------------
; find_dir
;
; Same as find_dirent, but with directory type check
;-----------------------------------------------------------------------------
.proc find_dir
	; Find directory entry
	jsr find_dirent
	bcc error

	; Check if this is a directory
	lda fat32_dirent + dirent::attributes
	bit #$10
	beq error

	; Success
	sec
	rts

error:	clc
	rts
.endproc

;-----------------------------------------------------------------------------
; delete
;-----------------------------------------------------------------------------
.proc delete
	; Find file
	jsr find_file
	bcc error

	; Mark file as deleted
	set16 bufptr, cur_context + context::dirent_bufptr
	lda #$E5
	sta (bufptr)

	; Write sector buffer to disk
	jsr save_sector_buffer
	bcc error

	; Unlink cluster chain
	set32 cur_context + context::cluster, fat32_dirent + dirent::cluster
	jmp unlink_cluster_chain

error:	rts
.endproc

;-----------------------------------------------------------------------------
; fat32_init
;-----------------------------------------------------------------------------
.proc fat32_init
	; Initialize SD card
	jsr sdcard_init
	bcc error

	; Initialize file contexts
	stz context_idx
	clear_bytes cur_context, contexts_end - cur_context

	; Make sure sector_lba is non-zero
	lda #$FF
	sta sector_lba

	; Set initial start point for free cluster search
	set32_val free_cluster, 2

	; Read partition table
	set32 cur_context + context::lba, 0
	jsr load_sector_buffer
	bcc error

	; Check partition type of first partition
	lda sector_buffer + $1BE + 4
	cmp #$0B
	beq :+
	cmp #$0C
	beq :+
error:	clc
	rts
:
	; Get LBA of first partition
	set32 lba_partition, sector_buffer + $1BE + 8

	; Read first sector of partition
	set32 cur_context + context::lba, lba_partition
	jsr load_sector_buffer
	bcc error

	; Some sanity checks
	lda sector_buffer + 510 ; Check signature
	cmp #$55
	bne error
	lda sector_buffer + 511
	cmp #$AA
	bne error
	lda sector_buffer + 16 ; # of FATs should be 2
	cmp #2
	bne error
	lda sector_buffer + 17 ; Root entry count = 0 for FAT32
	bne error
	lda sector_buffer + 18
	bne error

	; Get sectors per cluster
	lda sector_buffer + 13
	sta sectors_per_cluster
	beq error

	; Calculate shift amount based on sectors per cluster
	stz cluster_shift
l1:	lsr
	beq :+
	inc cluster_shift
	bra l1
:
	; FAT size in sectors
	set32 fat_size, sector_buffer + 36

	; Root cluster
	set32 rootdir_cluster, sector_buffer + 44

	; Calculate LBA of first FAT
	add32_16 lba_fat, lba_partition, sector_buffer + 14

	; Calculate LBA of first data sector
	add32 lba_data, lba_fat, fat_size
	add32 lba_data, lba_data, fat_size

	; Calculate number of clusters on volume: (total_sectors - lba_data) >> cluster_shift
	set32 cluster_count, sector_buffer + 32
	sub32 cluster_count, cluster_count, lba_data
	ldy cluster_shift
	beq :+
l2:	shr32 cluster_count
	dey
	bne l2
:
	; Get FS info sector
	add32_16 lba_fsinfo, lba_partition, sector_buffer + 48

	; Load FS info sector
	set32 cur_context + context::lba, lba_fsinfo
	jsr load_sector_buffer
	bcs :+
	rts
:
	; Get number of free clusters
	set32 free_clusters, sector_buffer + 488

	; Success
	sec
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
	set16 cur_context + context::bufptr, bufptr

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
	set16 bufptr, cur_context + context::bufptr

	; Reload sector
	lda cur_context + context::flags
	bit #FLAG_IN_USE
	beq reload_done
	jsr load_sector_buffer
	bcc error
reload_done:

done:	sec
	rts
error:	clc
	rts
.endproc

;-----------------------------------------------------------------------------
; fat32_open_cwd
;
; Open current working directory
;-----------------------------------------------------------------------------
.proc fat32_open_cwd
	; Check if context is free
	lda cur_context + context::flags
	bne error

	; Open current directory
	jsr open_cwd
	bcc error

	; Set context as in-use
	lda #FLAG_IN_USE
	sta cur_context + context::flags

	; Success
	sec
	rts

error:	clc
	rts
.endproc

;-----------------------------------------------------------------------------
; fat32_read_dirent
;-----------------------------------------------------------------------------
.proc fat32_read_dirent
read_entry:
	; Load next sector if at end of buffer
	cmp16_val bufptr, sector_buffer_end, :+
	lda #0
	jsr next_sector
	bcs :+
error:	clc     ; Indicate error
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
	beq error

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
	set32 cur_context + context::dirent_lba,    cur_context + context::lba
	set16 cur_context + context::dirent_bufptr, bufptr

	; Increment buffer pointer to next entry
	add16_val bufptr, bufptr, 32

	sec
	rts

next_entry:
	add16_val bufptr, bufptr, 32
	jmp read_entry
.endproc

;-----------------------------------------------------------------------------
; fat32_chdir
;-----------------------------------------------------------------------------
.proc fat32_chdir
	; Check if context is free
	lda cur_context + context::flags
	bne error

	; Find directory
	jsr find_dir
	bcc error

	; Set as current directory
	set32 cwd_cluster, fat32_dirent + dirent::cluster

	sec
	rts

error:	clc
	rts
.endproc

;-----------------------------------------------------------------------------
; fat32_rename
;-----------------------------------------------------------------------------
.proc fat32_rename
	; Check if context is free
	lda cur_context + context::flags
	bne error

	; Save first argument
	set16 tmp_buf, fat32_ptr

	; Make sure target name doesn't exist
	set16 fat32_ptr, fat32_ptr2
	jsr find_dirent
	bcc :+
error:	clc	; Error, file exists
	rts
:
	; Convert target filename into directory entry format
	set16 fat32_ptr, fat32_ptr2
	jsr convert_filename
	bcc error

	; Find file to rename
	set16 fat32_ptr, tmp_buf
	jsr find_dirent
	bcc error

	; Copy new filename into sector buffer
	set16 bufptr, cur_context + context::dirent_bufptr
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
; fat32_delete
;-----------------------------------------------------------------------------
.proc fat32_delete
	; Check if context is free
	lda cur_context + context::flags
	beq :+
	clc
	rts
:
	jmp delete
.endproc

;-----------------------------------------------------------------------------
; fat32_open
;
; Open file specified in string pointed to by fat32_ptr
;-----------------------------------------------------------------------------
.proc fat32_open
	; Check if context is free
	lda cur_context + context::flags
	bne error

	; Find file
	jsr find_file
	bcc error

	; Open file
	set32_val cur_context + context::file_offset, 0
	set32 cur_context + context::file_size, fat32_dirent + dirent::size
	set32 cur_context + context::cluster, fat32_dirent + dirent::cluster
	jsr open_cluster
	bcc error

	; Set context as in-use
	lda #FLAG_IN_USE
	sta cur_context + context::flags

	; Success
	sec
	rts

error:	clc
	rts
.endproc

;-----------------------------------------------------------------------------
; fat32_create
;-----------------------------------------------------------------------------
.proc fat32_create
	; Check if context is free
	lda cur_context + context::flags
	bne error

	; Save argument for re-use
	set16 fat32_ptr2, fat32_ptr

	; Delete file first is it exists
	jsr delete

	; Convert file name
	set16 fat32_ptr, fat32_ptr2
	jsr convert_filename
	bcc error

	; Find free directory entry
	jsr open_cwd
	bcc error

next_entry:
	; Load next sector if at end of buffer (allocate and clear new cluster if needed)
	cmp16_val bufptr, sector_buffer_end, :+
	lda #3
	jsr next_sector
	bcs :+
error:	clc
	rts
:
	; Is this entry free?
	lda (bufptr)
	beq free_entry
	cmp #$E5
	beq free_entry

	; Increment buffer pointer to next entry
	add16_val bufptr, bufptr, 32
	bra next_entry

	; Free directory entry found
free_entry:
	; Copy filename in new entry
	ldy #0
:	lda filename_buf, y
	sta (bufptr), y
	iny
	cpy #11
	bne :-

	; Zero fill rest of entry
	lda #0
:	sta (bufptr), y
	iny
	cpy #32
	bne :-

	; Save lba + bufptr
	set32 cur_context + context::dirent_lba,    cur_context + context::lba
	set16 cur_context + context::dirent_bufptr, bufptr

	; Write sector buffer to disk
	jsr save_sector_buffer
	bcc error

	; Set context as in-use
	lda #FLAG_IN_USE
	sta cur_context + context::flags

	; Set up bufptr to trigger cluster allocation at first write
	set16_val bufptr, sector_buffer_end

	sec
	rts
.endproc

;-----------------------------------------------------------------------------
; fat32_close
;
; Close current file
;-----------------------------------------------------------------------------
.proc fat32_close
	; Write current sector if dirty
	jsr sync_sector_buffer
	bcc error

	; Update directory entry with new size if needed
	lda cur_context + context::flags
	bit #FLAG_DIRENT
	beq done
	and #(FLAG_DIRENT ^ $FF)	; Clear bit
	sta cur_context + context::flags

	; Load sector of directory entry
	set32 cur_context + context::lba, cur_context + context::dirent_lba
	jsr load_sector_buffer
	bcc error

	; Write size to directory entry
	set16 bufptr, cur_context + context::dirent_bufptr
	ldy #28
	lda cur_context + context::file_size + 0
	sta (bufptr), y
	iny
	lda cur_context + context::file_size + 1
	sta (bufptr), y
	iny
	lda cur_context + context::file_size + 2
	sta (bufptr), y
	iny
	lda cur_context + context::file_size + 3
	sta (bufptr), y

	; Write directory sector
	jsr save_sector_buffer
	bcc error
done:
	clear_bytes cur_context, .sizeof(context)

	sec
	rts

error:	clc
	rts
.endproc

;-----------------------------------------------------------------------------
; fat32_read_byte
;-----------------------------------------------------------------------------
.proc fat32_read_byte
next:
	; Bytes remaining?
	cmp32 cur_context + context::file_offset, cur_context + context::file_size, :+
error:	clc
	rts
:
	; At end of buffer?
	cmp16_val bufptr, sector_buffer_end, :+
	lda #0
	jsr next_sector
	bcc error
:
	; Decrement bytes remaining
	inc32 cur_context + context::file_offset

	; Get byte from buffer
	lda (bufptr)
	inc16 bufptr

	sec	; Indicate success
	rts
.endproc

;-----------------------------------------------------------------------------
; write__end_of_buffer
;-----------------------------------------------------------------------------
.proc write__end_of_buffer
	; Is this the first cluster?
	lda cur_context + context::file_size + 0
	ora cur_context + context::file_size + 1
	ora cur_context + context::file_size + 2
	ora cur_context + context::file_size + 3
	beq allocate_first_cluster

	; Go to next sector (allocate cluster if needed)
	lda #1
	jmp next_sector

	; Allocate cluster and add it to the directory entry of this file
allocate_first_cluster:
	jsr allocate_cluster
	bcs :+
error:	rts
:
	; Load sector of directory entry
	set32 cur_context + context::lba, cur_context + context::dirent_lba
	jsr load_sector_buffer
	bcc error
	set16 bufptr, cur_context + context::dirent_bufptr

	; Write cluster number to directory entry
	ldy #26
	lda free_cluster + 0
	sta (bufptr), y
	iny
	lda free_cluster + 1
	sta (bufptr), y
	ldy #20
	lda free_cluster + 2
	sta (bufptr), y
	iny
	lda free_cluster + 3
	sta (bufptr), y

	; Write directory sector
	jsr save_sector_buffer
	bcc error

	; Load in cluster
	set32 cur_context + context::cluster, free_cluster
	jmp open_cluster
.endproc

;-----------------------------------------------------------------------------
; fat32_write_byte
;-----------------------------------------------------------------------------
.proc fat32_write_byte
	; At end of buffer? (preserve A)
	ldx bufptr + 0
	cpx #<sector_buffer_end
	bne write_byte
	ldx bufptr + 1
	cpx #>sector_buffer_end
	bne write_byte

	; Handle end of buffer condition
	pha
	jsr write__end_of_buffer
	pla
	bcs write_byte
	rts

write_byte:
	; Write byte
	sta (bufptr)
	inc16 bufptr

	; Set sector as dirty, dirent needs update
	lda cur_context + context::flags
	ora #(FLAG_DIRTY | FLAG_DIRENT)
	sta cur_context + context::flags

	inc32 cur_context + context::file_offset
	inc32 cur_context + context::file_size

	sec	; Indicate success
	rts
.endproc

;-----------------------------------------------------------------------------
; fat32_get_free_space
;-----------------------------------------------------------------------------
.proc fat32_get_free_space
	set32 fat32_size, free_clusters

	lda cluster_shift
	cmp #0	; 512B sectors
	beq _512b

	sec
	sbc #1
	tax
	cpx #0
	beq done
:	shl32 fat32_size
	dex
	bne :-

done:	sec
	rts

_512b:
	shr32 fat32_size
	bra done
.endproc
