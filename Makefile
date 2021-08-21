compile_boot:
	nasm -f bin -o ~/Документы/programming/asm/MW-OS/mw-os/bin/boot_loader.bin ~/Документы/programming/asm/MW-OS/mw-os/src/boot/boot_loader.asm

create_iso:
	genisoimage -iso-level 4 -o mw-os.iso ~/Документы/programming/asm/MW-OS/mw-os/bin/

create_iso_last:
	make compile_boot
	make create_iso

create_floppy:
	rm floppy.img
	mkdosfs -C floppy.img 1440
	dd conv=notrunc if=bin/boot_loader.bin of=floppy.img
