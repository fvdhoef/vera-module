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

ok:	lda #'1'
	jsr putchar

	jsr fat32_read_rootdir

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
