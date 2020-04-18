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
FAT32_CONTEXTS = 3              ; Set to 0/1 to disable contexts, max value: 8

;-----------------------------------------------------------------------------
; Variables
;-----------------------------------------------------------------------------
.globalzp fat32_ptr             ; Buffer pointer for various functions
.globalzp fat32_ptr2            ; Buffer pointer for various functions
.global   fat32_size            ; 16/32-bit value, used to pass retrieve sizes
.global   fat32_dirent          ; Directory entry result for fat32_read_dirent (struct dirent)

; Low level
.global fat32_cwd_cluster       ; Cluster of current working directory (can be used to save and restore working directory by user)
.global sector_buffer           ; Current sector buffer (can be used with fat32_next_sector)

;-----------------------------------------------------------------------------
; Functions
;-----------------------------------------------------------------------------

; Global operations
.global fat32_init              ; Initialize FAT32 driver and SD card
.global fat32_set_context       ; Set current context to idx in A (0..FAT32_CONTEXTS-1)
.global fat32_get_free_space    ; Get free space, result in KiB in fat32_size (32-bit)

; Directory operations
.global fat32_open_cwd          ; Open current working directory
.global fat32_read_dirent       ; Read directory entry, result in fat32_dirent

.global fat32_chdir             ; Change to directory with name in fat32_ptr
.global fat32_rename            ; Rename file with name in fat32_ptr to fat32_ptr2
.global fat32_delete            ; Delete file with name in fat32_ptr
.global fat32_mkdir             ; Create new directory with name in fat32_ptr
.global fat32_rmdir             ; Delete empty directory with name in fat32_ptr

; File operations
.global fat32_open              ; Open file with name in fat32_ptr
.global fat32_create            ; Create file with name in fat32_ptr (delete existing file)
.global fat32_close             ; Close file
.global fat32_read_byte         ; Read byte, result in A
.global fat32_read              ; Read fat32_size (16-bit) bytes to fat32_ptr
.global fat32_write_byte        ; Write byte in A
.global fat32_write             ; Write fat32_size (16-bit) bytes from fat32_ptr

; TODO:
; fat32_seek

; Low level fast API
.global fat32_next_sector
