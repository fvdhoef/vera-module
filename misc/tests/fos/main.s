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
	.zeropage

;-----------------------------------------------------------------------------
; Entry point
;-----------------------------------------------------------------------------
	.code
	.global entry
.proc entry
	; Switch to ISO mode
	lda #15
	jsr putchar

	jsr fat32_init
	bcs ok
	lda #'0'
	jsr putchar
	rts

ok:
.if 1
	lda #$63
	sta fat32_cluster + 0
	stz fat32_cluster + 1
	stz fat32_cluster + 2
	stz fat32_cluster + 3
.else
	copy_bytes fat32_cluster, fat32_rootdir_cluster, 4
.endif
	jsr fat32_open_cluster
	bcc error

.if 1
	lda #13
	jsr putchar

next_entry:
	jsr fat32_read_dirent
	bcc done

.if 1
	; Print file name
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
	lda fat32_dirent + dirent::attributes
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
.endif

	bra next_entry
done:
.endif

.if 0
:	jsr fat32_next_sector
	bcc :+
	bra :-
:
.endif

.if 0
:	jsr fat32_get_byte
	bcc :+
	cmp #' '
	bmi :-
	cmp #'~'
	bpl :-
	jsr putchar
	bra :-
:
.endif

error:
	rts

	; Return
	rts
.endproc

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
