org 0x7c00
bits 16

start:
    ; Your bootloader code begins here
    jmp main

main:
    ; The main part of your bootloader code
    ; ...

    hlt  ; Halt the CPU (for demonstration purposes)
    
    ; BIOS interrupt to indicate successful boot (optional)
    mov ah, 0
    int 16h

    ; Infinite loop to prevent program from falling through
.halt:
    jmp .halt

times 510-($-$$) db 0
dw 0xaa55

