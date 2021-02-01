[org 0x7c00]
mov ah, 0x0e ; Teletype
mov al, 'T'
int 0x10
mov al, 'e'
int 0x10
mov al, 's'
int 0x10
mov al, 't'
int 0x10

times 510 - ($-$$) db 0
dw 0xaa55
