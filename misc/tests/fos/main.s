;-----------------------------------------------------------------------------
; psgtest.s
;-----------------------------------------------------------------------------

	.include "lib.inc"

	.import sdcard_init, sdcard_read_sector, sdcard_write_sector
	.import lba
	.importzp bufptr

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
	jsr sdcard_init
	bcs ok
	lda #'0'
	jsr $FFD2
	rts

ok:	lda #'1'
	jsr $FFD2

	stz lba
	stz lba+1
	stz lba+2
	stz lba+3

again:
	lda #<buffer
	sta bufptr
	lda #>buffer
	sta bufptr+1
	jsr sdcard_read_sector

	inc lba+3
	bne again
	inc lba+2
	lda lba+2
	cmp #8
	bne again


	stz lba
	lda #1
	sta lba+1
	stz lba+2
	stz lba+3

again:
	lda #<buffer
	sta bufptr
	lda #>buffer
	sta bufptr+1
	jsr sdcard_write_sector

	inc lba+3
	bne again
	inc lba+2
	lda lba+2
	cmp #8
	bne again




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
	jsr $FFD2
	pla
	pha
	and #$0F
	tay
	lda hexstr,y
	jsr $FFD2

	lda #' '
	jsr $FFD2

	pla
	ply
	rts

hexstr: .byte "0123456789ABCDEF"
.endproc
