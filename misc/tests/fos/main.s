;-----------------------------------------------------------------------------
; main.s
;-----------------------------------------------------------------------------

	.include "lib.inc"
	.include "text_display.inc"
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
	bit #$10
	bne dir

	; Print size
	copy_bytes val32, fat32_dirent + dirent::size, 4
	lda #' '
	sta padch
	jsr print_val32

	bra cluster

dir:	ldy #0
:	lda dirstr, y
	beq :+
	jsr putchar
	iny
	bra :-
:
cluster:
.if 0
	; Spacing
	lda #' '
	jsr putchar

	; Print cluster
	; copy_bytes val32, fat32_dirent + dirent::cluster, 4
	; lda #0
	; sta padch
	; jsr print_val32

	ldx #3
:	lda fat32_dirent + dirent::cluster, x
	jsr puthex
	dex
	cpx #$FF
	bne :-
.endif

	; New line
	lda #10
	jsr putchar

	rts

dirstr: .byte "<DIR>     ", 0
.endproc

;-----------------------------------------------------------------------------
; main
;-----------------------------------------------------------------------------
.proc main
	; Init text display
	jsr text_display_init

	; Init FAT32
	jsr fat32_init
	bcs :+
	lda #'0'
	jsr putchar
	rts
:

	; stz SRC_PTR + 0
	; stz SRC_PTR + 1
	; lda #0
	; sta LENGTH + 0
	; lda #$10
	; sta LENGTH + 1

	; jsr hexdump

	; rts

blaat:
	; Context 0: root directory
	lda #0
	jsr fat32_set_context
	copy_bytes fat32_cluster, fat32_rootdir_cluster, 4
	jsr fat32_open_cluster
	bcc error

	; Context 1: sub-directory
	; lda #1
	; jsr fat32_set_context
	; lda #$63
	; sta fat32_cluster + 0
	; stz fat32_cluster + 1
	; stz fat32_cluster + 2
	; stz fat32_cluster + 3
	; jsr fat32_open_cluster
	; bcc error

	; lda #0
	; jsr fat32_set_context

:	jsr fat32_read_dirent
	bcc :+
	jsr print_dirent
	bra :-
:

; 	lda #1
; 	jsr fat32_set_context

; 	lda #10
; 	jsr putchar

; :	jsr fat32_read_dirent
; 	bcc :+
; 	jsr print_dirent
; 	bra :-
; :


	lda #']'
	jsr putchar

:	jsr $FFE4
	beq :-
	jsr putchar
	bra :-


	; jmp blaat
	; Return
	rts


error:
	rts
.endproc

;-----------------------------------------------------------------------------
; Entry point
;-----------------------------------------------------------------------------
	.global entry
.proc entry
	; sei

	; Disable display
	stz VERA_CTRL
	lda VERA_DC_VIDEO
	and #7
	sta VERA_DC_VIDEO

	jsr main
loop:	bra loop
.endproc
