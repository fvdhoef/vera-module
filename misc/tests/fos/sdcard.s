
	.include "lib.inc"

	.zeropage
bufptr:	.word 0
count:	.word 0

	.bss
cmdbuf: .res 6
buffer: .res 515

	.code

;-----------------------------------------------------------------------------
; deselect
; A:modified
;-----------------------------------------------------------------------------
.proc deselect
	lda VERA_SPI_CTRL
	and #$FE
	sta VERA_SPI_CTRL

	jsr spi_read
	rts
.endproc

;-----------------------------------------------------------------------------
; select
; A:modified
;-----------------------------------------------------------------------------
.proc select
	lda VERA_SPI_CTRL
	ora #$01
	sta VERA_SPI_CTRL

	jsr spi_read
:	jsr spi_read
	cmp #$FF
	bne :-

	rts
.endproc

;-----------------------------------------------------------------------------
; spi_read
; A: result
;-----------------------------------------------------------------------------
.proc spi_read
	lda #$FF
	sta VERA_SPI_DATA
:	bit VERA_SPI_CTRL
	bmi :-
	lda VERA_SPI_DATA
	rts
.endproc

;-----------------------------------------------------------------------------
; spi_read
; A: byte to write
;-----------------------------------------------------------------------------
.proc spi_write
	sta VERA_SPI_DATA
:	bit VERA_SPI_CTRL
	bmi :-
	rts
.endproc

;-----------------------------------------------------------------------------
; send_cmd - Send cmdbuf
; A: first byte of result, Y:modified
;-----------------------------------------------------------------------------
.proc send_cmd
	jsr deselect
	jsr select

	; Send the 6 cmdbuf bytes
	ldy #0
:	lda cmdbuf,y
	jsr spi_write
	iny
	cpy #6
	bne :-

	; Wait for response
	ldy #10
:	dey
	beq :+
	jsr spi_read
	bit #$80
	bne :-
:	rts
.endproc

;-----------------------------------------------------------------------------
; send_cmd_inline - send command with specified argument
;-----------------------------------------------------------------------------
.macro send_cmd_inline cmd, arg
	lda #(cmd | $40)
	sta cmdbuf+0

.if .hibyte(.hiword(arg)) = 0
	stz cmdbuf+1
.else
	lda #(.hibyte(.hiword(arg)))
	sta cmdbuf+1
.endif

.if ^arg = 0
	stz cmdbuf+2
.else
	lda #^arg
	sta cmdbuf+2
.endif

.if >arg = 0
	stz cmdbuf+3
.else
	lda #>arg
	sta cmdbuf+3
.endif

.if <arg = 0
	stz cmdbuf+4
.else
	lda #<arg
	sta cmdbuf+4
.endif

.if cmd = 0
	lda #$95
.else
.if cmd = 8
	lda #$87
.else
	lda #1
.endif
.endif
	sta cmdbuf+5
	jsr send_cmd
.endmacro


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

;-----------------------------------------------------------------------------
; sdcard_init
; result: C=0 -> error, C=1 -> success
;-----------------------------------------------------------------------------
	.global sdcard_init
.proc sdcard_init
	; Deselect card and set slow speed (< 400kHz)
	lda #2
	sta VERA_SPI_CTRL

	; Generate at least 74 SPI clock cycles with device deselected
	ldx #10
:	jsr spi_read
	dex
	bne :-

	; Enter idle state
	send_cmd_inline 0, 0
	cmp #1
	beq :+
	jmp error
:
	; SDv2? (SDHC/SDXC)
	send_cmd_inline 8, $1AA
	cmp #1
	beq :+
	jmp error
:

sdv2:	; Receive remaining 4 bytes of R7 response
	jsr spi_read
	jsr spi_read
	jsr spi_read
	jsr spi_read

	; Wait for card to leave idle state
:	send_cmd_inline 55, 0
	send_cmd_inline 41, $40000000
	cmp #0
	bne :-

	; Check CCS bit in OCR register
	send_cmd_inline 58, 0
	cmp #0
	jsr spi_read
	and #$40	; Check if this card supports block addressing mode
	beq error
	jsr spi_read
	jsr spi_read
	jsr spi_read

	; Success
	jsr deselect

	; Select full speed
	lda #0
	sta VERA_SPI_CTRL

	sec
	rts

error:	jsr deselect
	clc
	rts
.endproc
