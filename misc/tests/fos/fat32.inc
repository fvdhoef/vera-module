;-----------------------------------------------------------------------------
; fat32.inc
;-----------------------------------------------------------------------------

.struct dirent
file_name .res 13
file_size .dword
.endstruct

;-----------------------------------------------------------------------------
; Variables
;-----------------------------------------------------------------------------
	.global fat32_rootdir_cluster	; Cluster number of rootdir
	.global fat32_cluster		; Cluster argument to fat32_open_cluster

	.globalzp fat32_ptr
	.global   fat32_cnt

;-----------------------------------------------------------------------------
; Functions
;-----------------------------------------------------------------------------
	.global fat32_init
	.global fat32_open_cluster
	.global fat32_next_sector

	.global fat32_read

	.global fat32_read_dirent

	.global fat32_read_rootdir

