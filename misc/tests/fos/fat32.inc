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
	.global   fat32_rootdir_cluster  ; Cluster number of rootdir
	.global   fat32_cluster          ; Cluster argument to fat32_open_cluster
	.globalzp fat32_ptr              ; Buffer pointer for fat32_read
	.global   fat32_cnt              ; Read count for fat32_read
	.global   fat32_dirent           ; Directory entry result for fat32_read_dirent

;-----------------------------------------------------------------------------
; Functions
;-----------------------------------------------------------------------------
	.global fat32_init
	.global fat32_set_context
	.global fat32_open_cluster
	.global fat32_next_sector

	.global fat32_read
	.global fat32_get_byte
	.global fat32_read_dirent
