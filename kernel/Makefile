test:
	nasm -f bin test.asm -o test.bin
	qemu-system-x86_64 test.bin

clear:
	rm *.bin *.o *.iso

kernel:
		../i686-elf-tools-linux/bin/i686-elf-gcc -m32 -ffreestanding -I./ -c source/kernel.c -o kernel.o
		../i686-elf-tools-linux/bin/i686-elf-gcc -m32 -ffreestanding -I./ -c source/ports.c -o ports.o
		../i686-elf-tools-linux/bin/i686-elf-gcc -m32 -ffreestanding -I./ -c source/screen.c -o screen.o
		../i686-elf-tools-linux/bin/i686-elf-gcc -m32 -ffreestanding -I./ -c source/util.c -o util.o
		../i686-elf-tools-linux/bin/i686-elf-gcc -m32 -ffreestanding -I./ -c source/idt.c -o idt.o
		../i686-elf-tools-linux/bin/i686-elf-gcc -m32 -ffreestanding -I./ -c source/isr.c -o isr.o
		../i686-elf-tools-linux/bin/i686-elf-gcc -m32 -ffreestanding -I./ -c source/timer.c -o timer.o
		../i686-elf-tools-linux/bin/i686-elf-gcc -m32 -ffreestanding -I./ -c source/keyboard.c -o keyboard.o
		nasm interrupt.asm -f elf -o interrupt.o
		nasm kernel_entry.asm -f elf -o kernel_entry.o
		../i686-elf-tools-linux/bin/i686-elf-gcci686-elf-ld -o kernel.bin -Ttext 0x1000 kernel_entry.o kernel.o ports.o screen.o util.o idt.o isr.o interrupt.o timer.o keyboard.o --oformat binary
		nasm bootsect.asm -f bin -o bootsect.bin
		cat bootsect.bin kernel.bin > os-image.bin

qemu:
		qemu-system-x86_64 -fda os-image.bin
iso:
		truncate os-image.bin -s 1200k
		mkisofs -o os.iso -b os-image.bin ./
