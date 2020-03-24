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

	.code


.proc print_dirent
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

	rts
.endproc


;-----------------------------------------------------------------------------
; Entry point
;-----------------------------------------------------------------------------
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
	; Context 0: root directory
	lda #0
	jsr fat32_set_context
	copy_bytes fat32_cluster, fat32_rootdir_cluster, 4
	jsr fat32_open_cluster
	bcc error

	; Context 1: sub-directory
	lda #1
	jsr fat32_set_context
	lda #$63
	sta fat32_cluster + 0
	stz fat32_cluster + 1
	stz fat32_cluster + 2
	stz fat32_cluster + 3
	jsr fat32_open_cluster
	bcc error

	lda #0
	jsr fat32_set_context

	lda #13
	jsr putchar

:	jsr fat32_read_dirent
	bcc :+
	jsr print_dirent
	bra :-
:

	lda #1
	jsr fat32_set_context

	lda #13
	jsr putchar

:	jsr fat32_read_dirent
	bcc :+
	jsr print_dirent
	bra :-
:


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
	bcs :-
	cmp #'~'+1
	bcc :-
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
