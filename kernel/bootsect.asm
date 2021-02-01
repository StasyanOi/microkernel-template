[org 0x7c00]; отступ от начала программы на данный размер
KERNEL_OFFSET equ 0x1000 ; положение ядра относительно загрузчика

    mov [BOOT_DRIVE], dl ; сохраняем начало кода загрузчика
    mov bp, 0x9000 ; ставим базу стэка
    mov sp, bp; создаем стэк в реальном режиме

    mov bx, MSG_REAL_MODE ; сейчас программа в реальном режиме.
    call print
    call print_nl

    call load_kernel ; загружаем само ядро
    call switch_to_pm ; включаем защищенный режим
    jmp $ ;

%include "../asm/boot_sect_print.asm"
%include "../asm/boot_sect_print_hex.asm"
%include "../asm/boot_sect_disk.asm"
%include "../asm/32bit-gdt.asm"
%include "../asm/32bit-print.asm"
%include "../asm/32bit-switch.asm"

[bits 16]
load_kernel:
    mov bx, MSG_LOAD_KERNEL
    call print
    call print_nl

    mov bx, KERNEL_OFFSET ; грузим 2 сектора из памяти после загрузчика на адрес
    mov dh, 15 ; 0x0000:0x1000
    mov dl, [BOOT_DRIVE]
    call disk_load
    ret

[bits 32]
BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm
    call KERNEL_OFFSET ; вызываем начало ядра
    jmp $ ;


BOOT_DRIVE db 0 ;
MSG_REAL_MODE db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE db "Landed in 32-bit Protected Mode", 0
MSG_LOAD_KERNEL db "Loading kernel into memory", 0
sec: db 'X', 0
;
times 510 - ($-$$) db 0
dw 0xaa55
