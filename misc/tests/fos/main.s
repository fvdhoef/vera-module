;-----------------------------------------------------------------------------
; main.s
;-----------------------------------------------------------------------------

	.include "lib.inc"
	.include "fat32.inc"

;-----------------------------------------------------------------------------
; Variables
;-----------------------------------------------------------------------------
	.rodata

	.bss
buffer: .res 512

	.zeropage


;-----------------------------------------------------------------------------
; Entry point
;-----------------------------------------------------------------------------
	.code
	.global entry
entry:
	; Switch to ISO mode
	lda #15
	jsr putchar

	jsr fat32_init
	bcs ok
	lda #'0'
	jsr putchar
	rts

ok:	copy_bytes fat32_cluster, fat32_rootdir_cluster, 4
	jsr fat32_open_cluster
	bcc error

	lda #13
	jsr putchar

next_entry:
	jsr fat32_read_dirent
	bcc done

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
	lda fat32_dirent + dirent::attribute
	jsr hexbyte

	lda #' '
	jsr putchar
	jsr putchar

	; Print size
	ldx #3
:	lda fat32_dirent + dirent::size, x
	jsr hexbyte
	dex
	cpx #$FF
	bne :-

	lda #' '
	jsr putchar
	jsr putchar

	; Print cluster
	ldx #3
:	lda fat32_dirent + dirent::cluster, x
	jsr hexbyte
	dex
	cpx #$FF
	bne :-




	lda #13
	jsr putchar

	bra next_entry
done:

; :	jsr fat32_next_sector
; 	bcc :+
; 	bra :-
; :

; :	jsr fat32_get_byte
; 	bcc :+
; 	cmp #' '
; 	bmi :-
; 	cmp #'~'
; 	bpl :-
; 	jsr putchar
; 	bra :-
; :


error:
	rts

; 	jsr sdcard_init
; 	bcs ok
; 	lda #'0'
; 	jsr putchar
; 	rts

; ok:	lda #'1'
; 	jsr putchar

; 	stz lba
; 	stz lba+1
; 	stz lba+2
; 	stz lba+3

; again:
; 	lda #<buffer
; 	sta bufptr
; 	lda #>buffer
; 	sta bufptr+1
; 	jsr sdcard_read_sector

; 	inc lba+3
; 	bne again
; 	inc lba+2
; 	lda lba+2
; 	cmp #8
; 	bne again


; 	stz lba
; 	lda #1
; 	sta lba+1
; 	stz lba+2
; 	stz lba+3

; again:
; 	lda #<buffer
; 	sta bufptr
; 	lda #>buffer
; 	sta bufptr+1
; 	jsr sdcard_write_sector

; 	inc lba+3
; 	bne again
; 	inc lba+2
; 	lda lba+2
; 	cmp #8
; 	bne again




	; Wait forever
loop:	rts






;-----------------------------------------------------------------------------
; hexbyte
; A: byte to print
;-----------------------------------------------------------------------------
	.global hexbyte
.proc hexbyte
	phy
	pha
	lsr
	lsr
	lsr
	lsr
	tay
	lda hexstr,y
	jsr putchar
	pla
	pha
	and #$0F
	tay
	lda hexstr,y
	jsr putchar

	lda #' '
	jsr putchar

	pla
	ply
	rts

hexstr: .byte "0123456789ABCDEF"
.endproc
