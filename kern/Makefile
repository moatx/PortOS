include ../config.mk

OBJS = \
	$(OBJDIR)/entry.o \
	$(OBJDIR)/cons.o \
	$(OBJDIR)/$(ARCH).o \
	$(OBJDIR)/cpu_console.o \
	$(OBJDIR)/cpu.o \
	$(OBJDIR)/init_main.o


all:
	$(CC) $(CFLAGS) -D $(ARCH) -I ../include -c subr_cons.c -o $(OBJDIR)/cons.o
	$(CC) $(CFLAGS) -I ../include -c init_main.c  -o $(OBJDIR)/init_main.o 
	$(AS) -c ../arch/$(ARCH)/$(ARCH)/entry.S -o $(OBJDIR)/entry.o
	#$(LD) -s -e entry -o $(OBJDIR)/kernel.bin -Ttext 0x1000 $(OBJDIR)/entry.o $(OBJDIR)/cons.o $(OBJDIR)/$(ARCH).o $(OBJDIR)/cpu_console.o $(OBJDIR)/cpu.o $(OBJDIR)/init_main.o --oformat binary
	$(LD) -o $(OBJDIR)/kernel.bin -Ttext 0x1000  $(OBJS) --oformat binary

grub:
	$(CC) $(CFLAGS) -D $(ARCH) -I ../include -c subr_cons.c -o $(OBJDIR)/cons.o
	$(CC) $(CFLAGS) -I ../include -c init_main.c -o $(OBJDIR)/init_main.o
	$(AS) -c ../arch/$(ARCH)/$(ARCH)/entry.S -o $(OBJDIR)/entry.o
	#$(CC) $(CFLAGS) -T ../arch/$(ARCH)/kern.ld -o $(OBJDIR)/kernel.bin -ffreestanding -nostdlib $(OBJDIR)/$(ARCH).o $(OBJDIR)/cons.o $(OBJDIR)/cpu_console.o $(OBJDIR)/cpu.o $(OBJDIR)/init_main.o  $(OBJDIR)/entry.o -lgcc
	$(CC) $(CFLAGS) -T ../arch/$(ARCH)/kern.ld -o $(OBJDIR)/kernel.bin -ffreestanding -nostdlib $(OBJS) -lgcc

indent:
	indent init_main.c 
	indent subr_cons.c 
	@rm -f *.BAK


.PHONY: all grub indent
