;-----------------------------------------------------------------------------
; ps2.s
; Copyright (C) 2020 Frank van den Hoef
;-----------------------------------------------------------------------------

	.include "lib.inc"
	.include "ps2.inc"
        .include "text_display.inc"

;-----------------------------------------------------------------------------
; Variables
;-----------------------------------------------------------------------------
	.bss
ps2_parity: .byte 0	; PS/2 Parity ones counter
ps2_shift:  .byte 0	; PS/2 Shift register
ps2_idx:    .byte 0	; PS/2 Bit index
ps2_data:   .byte 0	; PS/2 Data

PS2_FIFO_SIZE = 32	; Make sure this is a power of 2

ps2_fifo:   .res PS2_FIFO_SIZE	; PS/2 FIFO
ps2_wridx:  .byte 0
ps2_rdidx:  .byte 0


FLAG_RELEASE  = 1<<0
FLAG_EXTENDED = 1<<1

decode_flags:   .byte 0

MOD_LCTRL  = 1<<0
MOD_LSHIFT = 1<<1
MOD_LALT   = 1<<2
MOD_LGUI   = 1<<3
MOD_RCTRL  = 1<<4
MOD_RSHIFT = 1<<5
MOD_RALT   = 1<<6
MOD_RGUI   = 1<<7

modifiers:      .byte 0

        .rodata
ps2_keyb_lut:
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $09, '`', $00
    .byte $00, $00, $00, $00, $00, 'q', '1', $00, $00, $00, 'z', 's', 'a', 'w', '2', $00
    .byte $00, 'c', 'x', 'd', 'e', '4', '3', $00, $00, ' ', 'v', 'f', 't', 'r', '5', $00
    .byte $00, 'n', 'b', 'h', 'g', 'y', '6', $00, $00, $00, 'm', 'j', 'u', '7', '8', $00
    .byte $00, ',', 'k', 'i', 'o', '0', '9', $00, $00, '.', '/', 'l', ';', 'p', '-', $00
    .byte $00, $00, $27, $00, '[', '=', $00, $00, $00, $00, $0A, ']', $00, $5C, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $08, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $1B, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00

ps2_keyb_lut_shifted:
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $09, '~', $00
    .byte $00, $00, $00, $00, $00, 'Q', '!', $00, $00, $00, 'Z', 'S', 'A', 'W', '@', $00
    .byte $00, 'C', 'X', 'D', 'E', '$', '#', $00, $00, ' ', 'V', 'F', 'T', 'R', '%', $00
    .byte $00, 'N', 'B', 'H', 'G', 'Y', '^', $00, $00, $00, 'M', 'J', 'U', '&', '*', $00
    .byte $00, '<', 'K', 'I', 'O', ')', '(', $00, $00, '>', '?', 'L', ':', 'P', '_', $00
    .byte $00, $00, '"', $00, '{', '+', $00, $00, $00, $00, $0A, '}', $00, '|', $00, $00
    .byte $00, $00, $00, $00, $00, $00, $08, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $1B, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00

        .code
;-----------------------------------------------------------------------------
; nmi_entry
;-----------------------------------------------------------------------------
.proc nmi_entry
        ; Save A,X registers
	pha
	phx

	; Get data bit in carry
	lda VIA2_IRA
	clc
	bit #1
	beq :+
	inc ps2_parity
	sec
:
	; Collect data bits
	ror ps2_shift

	; Check bit index
	ldx ps2_idx
	beq start_bit
	cpx #8
	beq data_done
	cpx #9
	beq partity_bit
	cpx #10
	beq stop_bit

next:	inc ps2_idx
        bra nmi_exit

start_bit:
	; Check start bit value
	bit #1
	bne reset	; Start bit not 0
	bra next

data_done:
	; Copy shift register to data register
	lda ps2_shift
	sta ps2_data
	bra next

partity_bit:
	; Check parity
	lda ps2_parity
	bit #1
	beq reset	; Incorrect parity bit
	bra next

stop_bit:
	; Check stop bit value
	bit #1
	beq reset	; Stop bit incorrect value

	; Check for space in FIFO and enqueue data byte
	ldx ps2_wridx
	txa
	inc
	and #(PS2_FIFO_SIZE-1)
	cmp ps2_rdidx
	beq :+		; No free space in FIFO, drop byte
	sta ps2_wridx
	lda ps2_data
	sta ps2_fifo, x
:

reset:	; Reset variables for next byte
	stz ps2_parity
	stz ps2_shift
	stz ps2_idx

nmi_exit:
        ; Restore A,X registers
	plx
	pla
	rti
.endproc

;-----------------------------------------------------------------------------
; ps2_getkey
;-----------------------------------------------------------------------------
.proc ps2_getkey
	; Check if data is available
	ldx ps2_rdidx
	cpx ps2_wridx
        beq done2

	; Read data
	lda ps2_fifo, x
	pha

	; Increment read index
	txa
	inc
	and #(PS2_FIFO_SIZE - 1)
	sta ps2_rdidx

	pla
        cmp #$F0
        beq release_code
        cmp #$E0
        beq extended
        cmp #$12
        beq lshift
        cmp #$59
        beq rshift

        tax

        lda decode_flags
        bit #FLAG_RELEASE
        bne done_nochar

        lda modifiers
        bit #(MOD_LSHIFT | MOD_RSHIFT)
        bne shifted

        ; Decode scancode unshifted
        lda ps2_keyb_lut, x
        bra decoded

shifted:
        ; Decode scancode shifted
        lda ps2_keyb_lut_shifted, x

decoded:
        beq done_nochar        ; Invalid char?
        stz decode_flags
        rts

done_nochar: 
        stz decode_flags
done2:  lda #0
	rts

release_code:
        lda decode_flags
        ora #FLAG_RELEASE
        sta decode_flags
        bra done2

extended:
        lda decode_flags
        ora #FLAG_EXTENDED
        sta decode_flags
        bra done2

lshift:
        lda decode_flags
        bit #FLAG_RELEASE
        bne lshift_release

        lda modifiers
        ora #MOD_LSHIFT
        sta modifiers
        bra done_nochar

lshift_release:
        lda modifiers
        and #(MOD_LSHIFT ^ $FF)
        sta modifiers
        bra done_nochar

rshift:
        lda decode_flags
        bit #FLAG_RELEASE
        bne rshift_release

        lda modifiers
        ora #MOD_RSHIFT
        sta modifiers
        bra done_nochar

rshift_release:
        lda modifiers
        and #(MOD_RSHIFT ^ $FF)
        sta modifiers
        bra done_nochar

.endproc
