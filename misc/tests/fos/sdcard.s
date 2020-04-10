;-----------------------------------------------------------------------------
; sdcard.s
; Copyright (C) 2020 Frank van den Hoef
;-----------------------------------------------------------------------------

	.include "lib.inc"
	.include "sdcard.inc"

	.zeropage
sdcard_bufptr:   .word 0

	.bss
cmdbuf:          .res 1
sdcard_lba_be:   .res 4	; Big-endian LBA, this is byte 1-5 of the command buffer
	         .res 1

	.code

;-----------------------------------------------------------------------------
; deselect card
;
; clobbers: A
;-----------------------------------------------------------------------------
.proc deselect
	lda VERA_SPI_CTRL
	and #$FE
	sta VERA_SPI_CTRL

	jsr spi_read
	rts
.endproc

;-----------------------------------------------------------------------------
; select card
;
; clobbers: A
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
;
; result in A
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
; spi_write
;
; byte to write in A
;-----------------------------------------------------------------------------
.proc spi_write
	sta VERA_SPI_DATA
:	bit VERA_SPI_CTRL
	bmi :-
	rts
.endproc

;-----------------------------------------------------------------------------
; send_cmd - Send cmdbuf
;
; first byte of result in A, clobbers: Y
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
	sta cmdbuf + 0

.if .hibyte(.hiword(arg)) = 0
	stz cmdbuf + 1
.else
	lda #(.hibyte(.hiword(arg)))
	sta cmdbuf + 1
.endif

.if ^arg = 0
	stz cmdbuf + 2
.else
	lda #^arg
	sta cmdbuf + 2
.endif

.if >arg = 0
	stz cmdbuf + 3
.else
	lda #>arg
	sta cmdbuf + 3
.endif

.if <arg = 0
	stz cmdbuf + 4
.else
	lda #<arg
	sta cmdbuf + 4
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
	sta cmdbuf + 5
	jsr send_cmd
.endmacro

;-----------------------------------------------------------------------------
; sdcard_init
; result: C=0 -> error, C=1 -> success
;-----------------------------------------------------------------------------
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

	; Select full speed
	jsr deselect
	lda #0
	sta VERA_SPI_CTRL

	; Success
	sec
	rts

error:	jsr deselect

	; Error
	clc
	rts
.endproc

;-----------------------------------------------------------------------------
; sdcard_read_sector
; Set sdcard_lba_be and sdcard_bufptr prior to calling this function.
; result: C=0 -> error, C=1 -> success
;-----------------------------------------------------------------------------
.proc sdcard_read_sector
	; Send READ_SINGLE_BLOCK command
	lda #($40 | 17)
	sta cmdbuf + 0
	lda #1
	sta cmdbuf + 5
	jsr send_cmd

	; Wait for start of data packet
	ldy #0
:	jsr spi_read
	cmp #$FE
	beq :+
	dey
	beq error
	bra :-
:
	; Read 512 bytes of sector data
	ldx #0
	ldy #2
read_loop:
	jsr spi_read
	sta (sdcard_bufptr)
	inc sdcard_bufptr + 0
	bne :+
	inc sdcard_bufptr + 1
:	dex
	bne read_loop
	dey
	bne read_loop

	; Read CRC bytes
	jsr spi_read
	jsr spi_read

	; Success
	jsr deselect
	sec
	rts

error:	; Error
	clc
	rts
.endproc

;-----------------------------------------------------------------------------
; sdcard_write_sector
; Set sdcard_lba_be and sdcard_bufptr prior to calling this function.
; result: C=0 -> error, C=1 -> success
;-----------------------------------------------------------------------------
.proc sdcard_write_sector
	; Send WRITE_BLOCK command
	lda #($40 | 24)
	sta cmdbuf + 0
	lda #1
	sta cmdbuf + 5
	jsr send_cmd
	cmp #00
	bne error

	; Send start of data token
	lda #$FE
	jsr spi_write

	; Send 512 bytes of sector data
	ldx #0
	ldy #2
write_loop:
	lda (sdcard_bufptr)
	jsr spi_write
	inc sdcard_bufptr + 0
	bne :+
	inc sdcard_bufptr + 1
:	dex
	bne write_loop
	dey
	bne write_loop

	; Dummy CRC
	lda #0
	jsr spi_write
	jsr spi_write

	; Success
	jsr deselect
	sec
	rts

error:	; Error
	jsr deselect
	clc
	rts
.endproc
