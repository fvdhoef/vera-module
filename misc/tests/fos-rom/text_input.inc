;-----------------------------------------------------------------------------
; text_input.inc
; Copyright (C) 2020 Frank van den Hoef
;-----------------------------------------------------------------------------

;-----------------------------------------------------------------------------
; Variables
;-----------------------------------------------------------------------------
MAX_LINE_LEN = 78

.global line_len
.global line_buf
.global line_start

;-----------------------------------------------------------------------------
; Functions
;-----------------------------------------------------------------------------
.global getchar
.global getline
.global to_upper
.global to_lower
.global skip_spaces
.global first_word_to_upper
.global terminate_and_skip_to_next_word
