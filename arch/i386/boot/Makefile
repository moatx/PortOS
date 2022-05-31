include ../../../config.mk

all:
	$(AS) -I ../include -c boot.S -o $(OBJDIR)/boot.o
	$(LD) -N -e _start -Ttext 0x7C00 -o $(OBJDIR)/bootblock.o $(OBJDIR)/boot.o 
	$(OBJCOPY) -S -O binary $(OBJDIR)/bootblock.o $(OBJDIR)/bootblock
	$(AS) -c kernel_entry.S -o $(OBJDIR)/kernel_entry.o

.PHONY: all
