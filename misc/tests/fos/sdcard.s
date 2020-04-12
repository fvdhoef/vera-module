;-----------------------------------------------------------------------------
; sdcard.s
; Copyright (C) 2020 Frank van den Hoef
;-----------------------------------------------------------------------------

	.include "lib.inc"
	.include "sdcard.inc"

	.bss
cmdbuf:          .res 1
sdcard_lba_be:   .res 4	; Big-endian LBA, this is byte 1-5 of the command buffer
	         .res 1

timeout_cnt:     .byte 0

	.code

;-----------------------------------------------------------------------------
; wait ready
;
; clobbers: A,X,Y
;-----------------------------------------------------------------------------
.proc wait_ready
	lda #2
	sta timeout_cnt

l3:	ldx #0			; 2
l2:	ldy #0			; 2
l1:	jsr spi_read		; 22
	cmp #$FF		; 2
	beq done		; 2 + 1
	dey			; 2
	bne l1			; 2 + 1
	dex			; 2
	bne l2			; 2 + 1
	dec timeout_cnt
	bne l3

	; Total timeout: ~508 ms @ 8MHz

	; Timeout error
	clc
	rts

done:	sec
	rts
.endproc

;-----------------------------------------------------------------------------
; deselect card
;
; clobbers: A
;-----------------------------------------------------------------------------
.proc deselect
	lda VERA_SPI_CTRL
	and #$FE
	sta VERA_SPI_CTRL

	jmp spi_read
.endproc

;-----------------------------------------------------------------------------
; select card
;
; clobbers: A,X,Y
;-----------------------------------------------------------------------------
.proc select
	lda VERA_SPI_CTRL
	ora #$01
	sta VERA_SPI_CTRL

	jsr spi_read
	jsr wait_ready
	bcc error
	rts

error:	jsr deselect
	clc
	rts
.endproc

;-----------------------------------------------------------------------------
; spi_read
;
; result in A
;-----------------------------------------------------------------------------
.proc spi_read
	lda #$FF		; 2
	sta VERA_SPI_DATA	; 4
l1:	bit VERA_SPI_CTRL	; 4
	bmi l1			; 2 + 1 if branch
	lda VERA_SPI_DATA	; 4
	rts			; 6
.endproc			; >= 22 cycles

; This macro will work correctly up to 8MHz
.macro spi_read_macro
	.local l1
	lda #$FF		; 2
	sta VERA_SPI_DATA	; 4

	; 640 ns / byte -> 5.12 clock cycles @ 8MHz
	nop			; 2
	nop			; 2
	nop			; 2

	lda VERA_SPI_DATA	; 4
.endmacro

;-----------------------------------------------------------------------------
; spi_write
;
; byte to write in A
;-----------------------------------------------------------------------------
.proc spi_write
	sta VERA_SPI_DATA
l1:	bit VERA_SPI_CTRL
	bmi l1
	rts
.endproc

;-----------------------------------------------------------------------------
; send_cmd - Send cmdbuf
;
; first byte of result in A, clobbers: Y
;-----------------------------------------------------------------------------
.proc send_cmd
	; Make sure card is deselected
	jsr deselect

	; Select card
	jsr select
	bcc error

	; Send the 6 cmdbuf bytes
	ldy #0
l1:	lda cmdbuf,y
	jsr spi_write
	iny
	cpy #6
	bne l1

	; Wait for response
	ldy #(10 + 1)
l2:	dey
	beq error	; Out of retries
	jsr spi_read
	bit #$80
	bne l2

	; Success
	sec
	rts

error:	; Error
	clc
	rts
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
l1:	jsr spi_read
	dex
	bne l1

	; Enter idle state
	send_cmd_inline 0, 0
	bcs :+
	jmp error
:
	cmp #1	; In idle state?
	beq :+
	jmp error
:
	; SDv2? (SDHC/SDXC)
	send_cmd_inline 8, $1AA
	bcs :+
	jmp error
:
	cmp #1	; No error?
	beq :+
	jmp error
:
sdv2:	; Receive remaining 4 bytes of R7 response
	jsr spi_read
	jsr spi_read
	jsr spi_read
	jsr spi_read

	; Wait for card to leave idle state
l2:	send_cmd_inline 55, 0
	bcs :+
	bra error
:
	send_cmd_inline 41, $40000000
	bcs :+
	bra error
:
	cmp #0
	bne l2

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
; Set sdcard_lba_be prior to calling this function.
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
	ldx #0
l2:	ldy #0
l1:	jsr spi_read
	cmp #$FE
	beq start
	dey
	bne l1
	dex
	bne l2

	; Timeout error
	jsr deselect
	clc
	rts

start:	; Read first byte
	ldx #$FF
	stx VERA_SPI_DATA
:	bit VERA_SPI_CTRL
	bmi :-

	; Efficiently read first 256 bytes (hide SPI transfer time)
:	lda VERA_SPI_DATA	; 4
	ldx #$FF		; 2
	stx VERA_SPI_DATA	; 4
	sta sector_buffer, y	; 5
	iny			; 2
	bne :-			; 2+1

	; Efficiently read second 256 bytes (hide SPI transfer time)
:	lda VERA_SPI_DATA		; 4
	ldx #$FF			; 2
	stx VERA_SPI_DATA		; 4
	sta sector_buffer + 256, y	; 5
	iny				; 2
	bne :-				; 2+1

	; Next read is now already done (first CRC byte), read second CRC byte
	jsr spi_read

	; Success
	jsr deselect
	sec
	rts
.endproc

;-----------------------------------------------------------------------------
; sdcard_write_sector
; Set sdcard_lba_be prior to calling this function.
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

	; Wait for card to be ready
	jsr wait_ready
	bcc error

	; Send start of data token
	lda #$FE
	jsr spi_write

	; Send 512 bytes of sector data
	; NOTE: Direct access of SPI registers to speed up.
	;       Make sure 9 CPU clock cycles take longer than 640 ns (eg. CPU max 14MHz)
	ldy #0
:	lda sector_buffer, y	; 4
	sta VERA_SPI_DATA	; 4
	iny			; 2
	bne :-			; 2 + 1

	; Y already 0 at this point
:	lda sector_buffer + 256, y	; 4
	sta VERA_SPI_DATA		; 4
	iny				; 2
	bne :-				; 2 + 1

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
