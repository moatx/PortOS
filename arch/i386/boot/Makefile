include ../../../config.mk

all:
	$(AS) -I ../include -c boot.S -o $(OBJDIR)/boot.o
	$(LD) -s -N -e _start -Ttext 0x7C00 -o $(OBJDIR)/boot.bin $(OBJDIR)/boot.o --oformat binary
	$(AS) -c entry.S -o $(OBJDIR)/entry.o

grub:
	$(AS) -c entry.S -o $(OBJDIR)/entry.o
	$(OBJCOPY) -S -O binary $(OBJDIR)/kernel_entry.o $(OBJDIR)/bootblock


.PHONY: all grub
