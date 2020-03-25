;-----------------------------------------------------------------------------
; regs.inc
;-----------------------------------------------------------------------------

;-----------------------------------------------------------------------------
; VIA1
;-----------------------------------------------------------------------------
VIA1_BASE  = $9F60
VIA1_ORB   = (VIA1_BASE + $0)
VIA1_ORA   = (VIA1_BASE + $1)
VIA1_IRB   = (VIA1_BASE + $0)
VIA1_IRA   = (VIA1_BASE + $1)
VIA1_DDRB  = (VIA1_BASE + $2)
VIA1_DDRA  = (VIA1_BASE + $3)
VIA1_T1CL  = (VIA1_BASE + $4)
VIA1_T1CH  = (VIA1_BASE + $5)
VIA1_T1LL  = (VIA1_BASE + $6)
VIA1_T1LH  = (VIA1_BASE + $7)
VIA1_T2CL  = (VIA1_BASE + $8)
VIA1_T2CH  = (VIA1_BASE + $9)
VIA1_SR    = (VIA1_BASE + $A)
VIA1_ACR   = (VIA1_BASE + $B)
VIA1_PCR   = (VIA1_BASE + $C)
VIA1_IFR   = (VIA1_BASE + $D)
VIA1_IER   = (VIA1_BASE + $E)
VIA1_ORANH = (VIA1_BASE + $F)
VIA1_IRANH = (VIA1_BASE + $F)

;-----------------------------------------------------------------------------
; VIA2
;-----------------------------------------------------------------------------
VIA2_BASE  = $9F70
VIA2_ORB   = (VIA2_BASE + $0)
VIA2_ORA   = (VIA2_BASE + $1)
VIA2_IRB   = (VIA2_BASE + $0)
VIA2_IRA   = (VIA2_BASE + $1)
VIA2_DDRB  = (VIA2_BASE + $2)
VIA2_DDRA  = (VIA2_BASE + $3)
VIA2_T1CL  = (VIA2_BASE + $4)
VIA2_T1CH  = (VIA2_BASE + $5)
VIA2_T1LL  = (VIA2_BASE + $6)
VIA2_T1LH  = (VIA2_BASE + $7)
VIA2_T2CL  = (VIA2_BASE + $8)
VIA2_T2CH  = (VIA2_BASE + $9)
VIA2_SR    = (VIA2_BASE + $A)
VIA2_ACR   = (VIA2_BASE + $B)
VIA2_PCR   = (VIA2_BASE + $C)
VIA2_IFR   = (VIA2_BASE + $D)
VIA2_IER   = (VIA2_BASE + $E)
VIA2_ORANH = (VIA2_BASE + $F)
VIA2_IRANH = (VIA2_BASE + $F)

;-----------------------------------------------------------------------------
; VERA
;-----------------------------------------------------------------------------
VERA_BASE         = $9F20

VERA_ADDR_L   	  = (VERA_BASE + $00)
VERA_ADDR_M   	  = (VERA_BASE + $01)
VERA_ADDR_H   	  = (VERA_BASE + $02)
VERA_DATA0        = (VERA_BASE + $03)
VERA_DATA1        = (VERA_BASE + $04)
VERA_CTRL         = (VERA_BASE + $05)

VERA_IEN          = (VERA_BASE + $06)
VERA_ISR          = (VERA_BASE + $07)
VERA_IRQ_LINE_L   = (VERA_BASE + $08)

VERA_DC_VIDEO     = (VERA_BASE + $09)
VERA_DC_HSCALE    = (VERA_BASE + $0A)
VERA_DC_VSCALE    = (VERA_BASE + $0B)
VERA_DC_BORDER    = (VERA_BASE + $0C)

VERA_DC_HSTART    = (VERA_BASE + $09)
VERA_DC_HSTOP     = (VERA_BASE + $0A)
VERA_DC_VSTART    = (VERA_BASE + $0B)
VERA_DC_VSTOP     = (VERA_BASE + $0C)

VERA_L0_CONFIG    = (VERA_BASE + $0D)
VERA_L0_MAPBASE   = (VERA_BASE + $0E)
VERA_L0_TILEBASE  = (VERA_BASE + $0F)
VERA_L0_HSCROLL_L = (VERA_BASE + $10)
VERA_L0_HSCROLL_H = (VERA_BASE + $11)
VERA_L0_VSCROLL_L = (VERA_BASE + $12)
VERA_L0_VSCROLL_H = (VERA_BASE + $13)

VERA_L1_CONFIG    = (VERA_BASE + $14)
VERA_L1_MAPBASE   = (VERA_BASE + $15)
VERA_L1_TILEBASE  = (VERA_BASE + $16)
VERA_L1_HSCROLL_L = (VERA_BASE + $17)
VERA_L1_HSCROLL_H = (VERA_BASE + $18)
VERA_L1_VSCROLL_L = (VERA_BASE + $19)
VERA_L1_VSCROLL_H = (VERA_BASE + $1A)

VERA_AUDIO_CTRL   = (VERA_BASE + $1B)
VERA_AUDIO_RATE   = (VERA_BASE + $1C)
VERA_AUDIO_DATA   = (VERA_BASE + $1D)

VERA_SPI_DATA     = (VERA_BASE + $1E)
VERA_SPI_CTRL     = (VERA_BASE + $1F)

VERA_PSG_BASE     = $1F9C0
VERA_PALETTE_BASE = $1FA00
VERA_SPRITES_BASE = $1FC00

;-----------------------------------------------------------------------------
; Zero-page kernal variables
;-----------------------------------------------------------------------------
SRC_PTR = $70
DST_PTR = $72
LENGTH  = $74

;-----------------------------------------------------------------------------
; KERNAL
;-----------------------------------------------------------------------------
CINV = $0314
