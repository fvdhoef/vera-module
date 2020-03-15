;-----------------------------------------------------------------------------
; psgtest.s
;-----------------------------------------------------------------------------

	.include "lib.inc"

;-----------------------------------------------------------------------------
; Variables
;-----------------------------------------------------------------------------
	.rodata
music_data: .incbin "music.bin"

	.bss
cinv_org:
	.word 0

	.zeropage
music_ptr:
	.word 0
framewait_cnt:
	.byte 0


;-----------------------------------------------------------------------------
; Entry point
;-----------------------------------------------------------------------------
	.code
	.global entry
entry:
	; Initialize music player
	jsr music_play_init

	; Install IRQ handler
	sei
	lda CINV
	sta cinv_org
	lda CINV + 1
	sta cinv_org + 1
	lda #<irq_handler
	sta CINV
	lda #>irq_handler
	sta CINV+1
	cli

	; Wait forever
loop:	jmp loop

;-----------------------------------------------------------------------------
; irq_handler
;-----------------------------------------------------------------------------
irq_handler:
	jsr vera_save

	; Show some activity by increasing upper left screen character
	stz VERA_ADDR_L
	stz VERA_ADDR_M
	stz VERA_ADDR_H
	inc VERA_DATA0

	; Play some music
	jsr music_play_irq

	jsr vera_restore

	; Call original interrupt vector
	jmp (cinv_org)

;-----------------------------------------------------------------------------
; music_play_init
;-----------------------------------------------------------------------------
music_play_init:
	lda #<music_data
	sta music_ptr
	lda #>music_data
	sta music_ptr+1
	lda #0
	sta framewait_cnt

	lda #^VERA_PSG_BASE
	sta VERA_ADDR_H
	lda #>VERA_PSG_BASE
	sta VERA_ADDR_M

	; Set square wave for all 3 channels
	lda #<VERA_PSG_BASE + 3
	sta VERA_ADDR_L
	lda #$7F
	sta VERA_DATA0

	lda #<VERA_PSG_BASE + 7
	sta VERA_ADDR_L
	lda #$7F
	sta VERA_DATA0

	lda #<VERA_PSG_BASE + 11
	sta VERA_ADDR_L
	lda #$7F
	sta VERA_DATA0

	rts

;-----------------------------------------------------------------------------
; music_play_irq
;-----------------------------------------------------------------------------
music_play_irq:
	lda framewait_cnt
	beq @music_handler
	dec framewait_cnt
	jmp @music_done

@music_handler:
	lda #$01
	sta VERA_ADDR_H
	lda #$F9
	sta VERA_ADDR_M

	; Load command byte
	lda (music_ptr)

	; Check end-of-music?
	cmp #$00
	bne @handle_cmd
	jmp @music_done

@handle_cmd:
	; Next byte
	inc music_ptr
	bne :+
	inc music_ptr+1
:
	; Check command byte
	cmp #$10
	beq @freq_ch0
	cmp #$11
	beq @freq_ch1
	cmp #$12
	beq @freq_ch2
	cmp #$20
	beq @vol_ch0
	cmp #$21
	beq @vol_ch1
	cmp #$22
	beq @vol_ch2
	cmp #$30
	beq @wait_frames
	jmp @music_done

@freq_ch0:
	; Lower frequency byte
	lda #<VERA_PSG_BASE + 0
	sta VERA_ADDR_L
	lda (music_ptr)
	sta VERA_DATA0

	; Next byte
	inc music_ptr
	bne :+
	inc music_ptr+1
:
	; Upper frequency byte
	lda #<VERA_PSG_BASE + 1
	sta VERA_ADDR_L
	lda (music_ptr)
	sta VERA_DATA0

	bra @next_cmd

@freq_ch1:
	; Lower frequency byte
	lda #<VERA_PSG_BASE + 4
	sta VERA_ADDR_L
	lda (music_ptr)
	sta VERA_DATA0

	; Next byte
	inc music_ptr
	bne :+
	inc music_ptr+1
:
	; Upper frequency byte
	lda #<VERA_PSG_BASE + 5
	sta VERA_ADDR_L
	lda (music_ptr)
	sta VERA_DATA0

	bra @next_cmd

@freq_ch2:
	; Lower frequency byte
	lda #<VERA_PSG_BASE + 8
	sta VERA_ADDR_L
	lda (music_ptr)
	sta VERA_DATA0

	; Next byte
	inc music_ptr
	bne :+
	inc music_ptr+1
:
	; Upper frequency byte
	lda #<VERA_PSG_BASE + 9
	sta VERA_ADDR_L
	lda (music_ptr)
	sta VERA_DATA0

	bra @next_cmd

@vol_ch0:
	; Volume byte
	lda #<VERA_PSG_BASE + 2
	sta VERA_ADDR_L
	lda (music_ptr)
	sta VERA_DATA0

	bra @next_cmd

@vol_ch1:
	; Volume byte
	lda #<VERA_PSG_BASE + 6
	sta VERA_ADDR_L
	lda (music_ptr)
	sta VERA_DATA0

	bra @next_cmd

@vol_ch2:
	; Volume byte
	lda #<VERA_PSG_BASE + 10
	sta VERA_ADDR_L
	lda (music_ptr)
	sta VERA_DATA0

	bra @next_cmd

@wait_frames:
	; Wait frame count byte
	lda (music_ptr)
	sta framewait_cnt

	; Next byte
	inc music_ptr
	bne :+
	inc music_ptr+1
:
	; Done for this vsync
	bra @music_done

@next_cmd:
	; Next byte
	inc music_ptr
	bne :+
	inc music_ptr+1
:
	jmp @music_handler

@music_done:
	rts
