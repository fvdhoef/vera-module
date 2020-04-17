;-----------------------------------------------------------------------------
; fat32.inc
; Copyright (C) 2020 Frank van den Hoef
;-----------------------------------------------------------------------------

.struct dirent
name       .res 13
attributes .byte
size       .dword
cluster    .dword
.endstruct

; Maximum number of open files.
FAT32_CONTEXTS = 6

;-----------------------------------------------------------------------------
; Variables
;-----------------------------------------------------------------------------
.globalzp fat32_ptr              ; Buffer pointer for various functions
.globalzp fat32_ptr2             ; Buffer pointer for various functions
.global   fat32_size             ; Used for fat32_get_free_space result
.global   fat32_dirent           ; Directory entry result for fat32_read_dirent

;-----------------------------------------------------------------------------
; Functions
;-----------------------------------------------------------------------------

; Global operations
.global fat32_init
.global fat32_set_context
.global fat32_get_free_space    ; Get free space, result in KiB in fat32_size

; Directory operations
.global fat32_open_cwd          ; Open current working directory
.global fat32_read_dirent       ; Read directory entry, result in fat32_dirent

.global fat32_chdir             ; Change to directory with name in fat32_ptr
.global fat32_rename            ; Rename file with name in fat32_ptr to fat32_ptr2
.global fat32_delete            ; Delete file with name in fat32_ptr
.global fat32_mkdir             ; Create new directory

; File operations
.global fat32_open              ; Open file with name in fat32_ptr
.global fat32_create            ; Create file with name in fat32_ptr (delete existing file)
.global fat32_close             ; Close file
.global fat32_read_byte         ; Read byte, result in A
.global fat32_read              ; Read fat32_size bytes to fat32_ptr
.global fat32_write_byte        ; Write byte in A
.global fat32_write             ; Write fat32_size bytes from fat32_ptr

; TODO:
; fat32_rmdir
; fat32_seek

; Low level fast API
.global sector_buffer
.global fat32_next_sector
