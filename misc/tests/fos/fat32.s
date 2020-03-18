;-----------------------------------------------------------------------------
; fat32.s
;-----------------------------------------------------------------------------

	.include "lib.inc"

	.import hexbyte
	.import sdcard_init, sdcard_read_sector, sdcard_write_sector
	.import lba_be
	.importzp bufptr

;-----------------------------------------------------------------------------
; Variables
;-----------------------------------------------------------------------------
	.zeropage

	.bss

cluster_shift:  .byte 0
lba_partition:  .dword 0
fat_size:       .dword 0
root_cluster:   .dword 0
lba_fat:        .dword 0
lba_data:       .dword 0

buffer: .res 512

current_cluster: .dword 0
lba_cluster:     .dword 0	; Sector of current cluster

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
	bne :+
	jmp error
	stz cluster_shift
:	lsr
	beq :+
	inc cluster_shift
	bra :-
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
; calc_lba_cluster
;-----------------------------------------------------------------------------
.proc calc_lba_cluster
	; lba_cluster = lba_data + ((current_cluster - 2) << cluster_shift)

	sub32_val lba_cluster, current_cluster, 2

	ldy cluster_shift
	beq shift_done
:	asl lba_cluster+0
	rol lba_cluster+1
	rol lba_cluster+2
	rol lba_cluster+3
	dey
	bne :-
shift_done:

	add32 lba_cluster, lba_cluster, lba_data

	rts
.endproc

;-----------------------------------------------------------------------------
; fat32_read_rootdir
;-----------------------------------------------------------------------------
	.global fat32_read_rootdir
.proc fat32_read_rootdir
	copy_bytes current_cluster, root_cluster, 4
	jsr calc_lba_cluster

	read_lba lba_cluster, buffer, error

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

	; Skip empty entries
	ldy #0
	lda (bufptr),y
	beq done
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





	; lda lba_cluster + 3
	; jsr hexbyte
	; lda lba_cluster + 2
	; jsr hexbyte
	; lda lba_cluster + 1
	; jsr hexbyte
	; lda lba_cluster + 0
	; jsr hexbyte



	
	; lba_data + (root_cluster - 2) << cluster_shift

	sec
	rts

error:	clc
	rts
.endproc
