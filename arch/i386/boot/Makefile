include ../../../config.mk

all:
	$(AS) -I ../include -c boot.S -o ../../../compile/boot.o
	$(LD) -N -e _start -Ttext 0x7C00 -o ../../../compile/bootblock.o ../../../compile/boot.o 
	$(OBJCOPY) -S -O binary ../../../compile/bootblock.o ../../../compile/bootblock
	sh sign.sh ../../../compile/bootblock
	$(AS) -c kernel_entry.S -o ../../../compile/kernel_entry.o
	
	
