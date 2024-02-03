org 0x7c00	;directives
bits 16

%define ENDL 0x0d, 0x0a

;FAT32 header
jmp short start
nop

bdb_oem:						db 'MSWIN14.1' 
bd


start:
	jmp main

main: 
	;setup data segments
	mov ax, 0
	mov ds, ax
	mov es, ax

	;setup stack
	mov ss, ax
	mov sp, 0x7c00	;stack grows downwards from we are in memory

	mov si,loading
	call puts
	mov si,dots
	call loadingdots

	mov si,yesorno
	call puts
	
	mov al,0
	;read character
	mov ah, 0x00
	int 0x16		;BIOS interrupt to get keyboard input
	mov ah,0x0e
	int 0x10		;BIOS interrupt to display
	
	mov si,newline
	call puts
	
	cmp al,'n'
	jz skip
	
	;print message
	mov si,msg_hello
	call puts
	mov si,dots
	call loadingdots
skip:
	mov si,lowpower	
	call puts
l1:
	mov ah,0x00
	int 0x16
	cmp al,0xd	;13-ascii code for enter key 
	jne l1
	
	mov si,end
	call puts
	
	hlt

.halt:
	jmp .halt

	
;print function body
puts:
	;save register
	push si
	push ax
.loop:
	lodsb		;load next character (value at address of si goes to al register then increments) in al
	or al, al 	;verify if next character is null?
	jz .done	;jz - contitional branch(jump when z_flag==high)
	mov ah, 0x0e	;call bios interrupt
	mov bh, 0 		;bh - page number(text mode)
	int 0x10		;int - interrupt
	jmp .loop
.done:
	pop ax
	pop si
	ret

	
loadingdots:
	;save register
	push si
	push ax
.loop1:
	lodsb		;load next character (value at address of si goes to al register then increments) in al
	or al, al 	;verify if next character is null?
	jz .done1	;jz - contitional branch(jump when z_flag==high)
	mov ah, 0x0e	;call bios interrupt
	mov bh, 0 		;bh - page number(text mode)
	int 0x10		;int - interrupt
	;one second delay
	mov ah,0x86
	mov cx,0x000f
	mov dx,0x4240
	int 0x15
	jmp .loop1
.done1:
	pop ax
	pop si
	ret


msg_hello: db  'Hello World', 0
newline: db ENDL,0
dots: db '.....',ENDL,0
yesorno: db 'Press y/n:',ENDL,0
loading: db 'Loading bootloader', 0
lowpower: db 'Press Enter to goto low-power mode',ENDL,0
end: db 'CPU is in low-power mode',ENDL,0
times 510-($-$$) db 0
dw 0aa55h
