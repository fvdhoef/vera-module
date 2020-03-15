;-----------------------------------------------------------------------------
; pcmtest.s
;-----------------------------------------------------------------------------

	.include "lib.inc"

;-----------------------------------------------------------------------------
; Variables
;-----------------------------------------------------------------------------
	.rodata
sample:
	.incbin "okay-bye.raw"
sample_end:

	.zeropage
audio_ptr:
	.word 0
audio_end:
	.word 0

;-----------------------------------------------------------------------------
; Entry point
;-----------------------------------------------------------------------------
	.code
	.global entry
entry:
	lda #$0F
	sta VERA_AUDIO_CTRL
	lda #64
	sta VERA_AUDIO_RATE

@play_sample:
	lda #<sample
	sta audio_ptr
	lda #>sample
	sta audio_ptr+1
	lda #<sample_end
	sta audio_end
	lda #>sample_end
	sta audio_end+1

@sample_loop:
	lda audio_ptr
	cmp audio_end
	bne @not_done
	lda audio_ptr+1
	cmp audio_end+1
	beq @done
@not_done:

@wait:	bit VERA_AUDIO_CTRL
	bmi @wait

	lda (audio_ptr)
	sta VERA_AUDIO_DATA

	inc audio_ptr
	bne @sample_loop
	inc audio_ptr+1
	bra @sample_loop

@done:	inc VERA_AUDIO_RATE
	jmp @play_sample

loop:	jmp loop
