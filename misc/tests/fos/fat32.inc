;-----------------------------------------------------------------------------
; fat32.inc
;-----------------------------------------------------------------------------

.struct dirent
name       .res 13
attributes .byte
size       .dword
cluster    .dword
.endstruct

;-----------------------------------------------------------------------------
; Variables
;-----------------------------------------------------------------------------
	.global fat32_rootdir_cluster	; Cluster number of rootdir
	.global fat32_cluster		; Cluster argument to fat32_open_cluster

	.globalzp fat32_ptr
	.global   fat32_cnt
	.global   fat32_dirent

;-----------------------------------------------------------------------------
; Functions
;-----------------------------------------------------------------------------
	.global fat32_init
	.global fat32_open_cluster
	.global fat32_next_sector

	.global fat32_read
	.global fat32_get_byte

	.global fat32_read_dirent
