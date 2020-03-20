;-----------------------------------------------------------------------------
; fat32.s
;-----------------------------------------------------------------------------

	.include "lib.inc"

	.import hexbyte
	.import sdcard_init, sdcard_read_sector, sdcard_write_sector
	.import lba_be
	.importzp bufptr

.struct filedesc
current_cluster .dword
current_lba     .dword
dirent_lba      .dword
dirent_offset   .word
file_size       .dword
file_offset     .dword
.endstruct

;-----------------------------------------------------------------------------
; Variables
;-----------------------------------------------------------------------------
	.zeropage
current_fd: .word 0

	.bss

; fd: .tag filedesc

sectors_per_cluster: .byte 0
cluster_shift:       .byte 0
lba_partition:       .dword 0
fat_size:            .dword 0
root_cluster:        .dword 0
lba_fat:             .dword 0
lba_data:            .dword 0

buffer: .res 512



current_cluster:        .dword 0
current_lba:            .dword 0	; Sector of current cluster
current_cluster_sector: .byte 0



	.code

;-----------------------------------------------------------------------------
; read_lba
;-----------------------------------------------------------------------------
.macro read_lba lba, buffer, error
	lda lba+0
	sta lba_be+3
	lda lba+1
	sta lba_be+2
	lda lba+2
	sta lba_be+1
	lda lba+3
	sta lba_be+0
	lda #<buffer
	sta bufptr
	lda #>buffer
	sta bufptr+1
	jsr sdcard_read_sector
	bcs :+
	jmp error
:
.endmacro

;-----------------------------------------------------------------------------
; fat32_init
;-----------------------------------------------------------------------------
	.global fat32_init
.proc fat32_init
	jsr sdcard_init
	bcs :+
	jmp error
:
	; Read partition table
	stz lba_be
	stz lba_be+1
	stz lba_be+2
	stz lba_be+3
	lda #<buffer
	sta bufptr
	lda #>buffer
	sta bufptr+1
	jsr sdcard_read_sector
	bcs :+
	jmp error
:
	; Check partition type of first partition
	lda buffer + $1BE + 4
	cmp #$0B
	beq :+
	cmp #$0C
	beq :+
	jmp error
:
	; Copy LBA of partition of first partition
	ldy #0
:	lda buffer + $1BE + 8, y
	sta lba_partition, y
	iny
	cpy #4
	bne :-

	; Read first sector of FAT32 partition
	read_lba lba_partition, buffer, error

	; Some sanity checks
	lda buffer + 510 ; Check signature
	cmp #$55
	bne @error
	lda buffer + 511
	cmp #$AA
	bne @error
	lda buffer + 16	; # of FATs should be 2
	cmp #2
	bne @error
	lda buffer + 17 ; Root entry count = 0 for FAT32
	bne @error
	lda buffer + 18
	bne @error
	bra :+
@error:	jmp error
:
	; Calculate shift amount based on sectors per cluster field
	lda buffer + 13
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
	copy_bytes fat_size, buffer+36, 4

	; Root cluster
	copy_bytes root_cluster, buffer+44, 4

	; Calculate LBA of first FAT
	add32_16 lba_fat, lba_partition, buffer + 14

	; Calculate LBA of first data sector
	add32 lba_data, lba_fat, fat_size
	add32 lba_data, lba_data, fat_size

	sec
	rts

error:	clc
	rts
.endproc

;-----------------------------------------------------------------------------
; calc_cluster_lba
;-----------------------------------------------------------------------------
.proc calc_cluster_lba
	; current_lba = lba_data + ((current_cluster - 2) << cluster_shift)
	sub32_val current_lba, current_cluster, 2
	ldy cluster_shift
	beq shift_done
:	asl current_lba+0
	rol current_lba+1
	rol current_lba+2
	rol current_lba+3
	dey
	bne :-
shift_done:

	add32 current_lba, current_lba, lba_data
	stz current_cluster_sector

	rts
.endproc

;-----------------------------------------------------------------------------
; next_cluster
;-----------------------------------------------------------------------------
.proc next_cluster
	; Calculate sector where cluster entry is located

	; current_lba = (current_cluster / 128) + lba_fat
	lda current_cluster+1
	sta current_lba+0
	lda current_cluster+2
	sta current_lba+1
	lda current_cluster+3
	sta current_lba+2
	stz current_lba+3
	lda current_cluster+0
	asl	; upper bit in C
	rol current_lba+0
	rol current_lba+1
	rol current_lba+2
	rol current_lba+3
	add32 current_lba, current_lba, lba_fat

	; read FAT sector
	read_lba current_lba, buffer, error

	lda current_cluster
	asl
	asl
	tay
	bcs upper_half	; In first or second 256 byte part of sector?

	; Copy FAT entry into current_cluster
	ldx #0
:	lda buffer,y
	sta current_cluster,x
	iny
	inx
	cpx #4
	bne :-

	lda #13
	jsr $FFD2

	bra done

upper_half:
	; Copy FAT entry into current_cluster
	ldx #0
:	lda buffer+256,y
	sta current_cluster,x
	iny
	inx
	cpx #4
	bne :-

done:
	; Check if this is the end of cluster chain (entry >= 0x0FFFFFF8)
	lda current_cluster+3
	cmp #$0F
	bcc :+
	lda current_cluster+2
	cmp #$FF
	bne :+
	lda current_cluster+1
	cmp #$FF
	bne :+
	lda current_cluster+0
	cmp #$F8
	bcs error
:
	sec
	rts

error:	clc
	rts

.endproc


;-----------------------------------------------------------------------------
; fat32_open_rootdir
;-----------------------------------------------------------------------------
	.global fat32_open_rootdir
.proc fat32_open_rootdir
	copy_bytes current_cluster, root_cluster, 4
	jsr calc_cluster_lba
	read_lba current_lba, buffer, error
done:	sec
	rts

error:	clc
	rts
.endproc

;-----------------------------------------------------------------------------
; fat32_next_sector
;-----------------------------------------------------------------------------
	.global fat32_next_sector
.proc fat32_next_sector
	inc current_cluster_sector
	lda current_cluster_sector
	cmp sectors_per_cluster
	beq end_of_cluster

	inc32 current_lba

read_sector:
	read_lba current_lba, buffer, error
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
; fat32_read_rootdir
;-----------------------------------------------------------------------------
	.global fat32_read_rootdir
.proc fat32_read_rootdir
	copy_bytes current_cluster, root_cluster, 4
	jsr calc_cluster_lba
	read_lba current_lba, buffer, error

start:
	lda #<(buffer)
	sta bufptr
	lda #>(buffer)
	sta bufptr+1

	lda #13
	jsr $FFD2

	ldx #16
print_entry:
	; Skip volume label entries
	ldy #11
	lda (bufptr),y
	and #8
	bne next_entry

	; Last entry?
	ldy #0
	lda (bufptr),y
	beq last_entry

	; Skip empty entries
	cmp #$E5
	beq next_entry

	ldy #0
:	lda (bufptr),y
	jsr $FFD2
	iny
	cpy #11
	bne :-

	lda #' '
	jsr $FFD2


	ldy #21
	lda (bufptr),y
	jsr hexbyte
	dey
	lda (bufptr),y
	jsr hexbyte
	ldy #26
	lda (bufptr),y
	jsr hexbyte
	dey
	lda (bufptr),y
	jsr hexbyte


	; New line
	lda #13
	jsr $FFD2

next_entry:
	; Go to next entry
	clc
	lda bufptr
	adc #32
	sta bufptr
	lda bufptr+1
	adc #0
	sta bufptr+1

	dex
	cpx #0
	bne print_entry
done:
	jsr fat32_next_sector
	bcc :+
	jmp start
:

last_entry:

	; lda current_lba + 3
	; jsr hexbyte
	; lda current_lba + 2
	; jsr hexbyte
	; lda current_lba + 1
	; jsr hexbyte
	; lda current_lba + 0
	; jsr hexbyte



	
	; lba_data + (root_cluster - 2) << cluster_shift

	sec
	rts

error:	clc
	rts
.endproc
