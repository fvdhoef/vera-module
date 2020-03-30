;-----------------------------------------------------------------------------
; fat32.inc
;-----------------------------------------------------------------------------

.struct dirent
name       .res 13
attributes .byte
size       .dword
cluster    .dword
.endstruct

; Maximum number of open files.
FAT32_CONTEXTS = 3

;-----------------------------------------------------------------------------
; Variables
;-----------------------------------------------------------------------------
.globalzp fat32_ptr              ; Buffer pointer for fat32_read
.globalzp fat32_ptr2             ; Buffer pointer
.global   fat32_size             ; Read count for fat32_read
.global   fat32_dirent           ; Directory entry result for fat32_read_dirent

;-----------------------------------------------------------------------------
; Functions
;-----------------------------------------------------------------------------
.global fat32_init
.global fat32_set_context

; Higher level
.global fat32_open_cwd
.global fat32_open_file
.global fat32_chdir

.global fat32_read
.global fat32_get_byte
.global fat32_read_dirent
.global fat32_find_file
.global fat32_find_dirent
.global fat32_rename
.global fat32_delete
