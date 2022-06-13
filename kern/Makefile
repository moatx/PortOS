include ../config.mk

all:
	$(CC) $(CFLAGS) -D $(ARCH) -I ../include -c subr_cons.c -o $(OBJDIR)/cons.o
	$(CC) $(CFLAGS) -I ../include -c init_main.c  -o $(OBJDIR)/init_main.o 
	$(AS) -c $(HEAD)/arch/$(ARCH)/boot/entry.S -o $(OBJDIR)/entry.o
	$(LD) -s -o $(OBJDIR)/kernel.bin -Ttext 0x1000 $(OBJDIR)/entry.o $(OBJDIR)/cons.o $(OBJDIR)/cpu_console.o $(OBJDIR)/cpu.o $(OBJDIR)/init_main.o --oformat binary

grub:
	$(CC) $(CFLAGS) -D $(ARCH) -I ../include -c subr_cons.c -o $(OBJDIR)/cons.o
	$(CC) $(CFLAGS) -I ../include -c init_main.c -o $(OBJDIR)/init_main.o
	$(AS) -c $(HEAD)/arch/$(ARCH)/boot/entry.S -o $(OBJDIR)/entry.o
	$(CC) $(CFLAGS) -T $(HEAD)/arch/$(ARCH)/boot/kern.ld -o $(OBJDIR)/kernel.bin -ffreestanding -nostdlib $(OBJDIR)/cons.o $(OBJDIR)/cpu_console.o $(OBJDIR)/cpu.o $(OBJDIR)/init_main.o  $(OBJDIR)/entry.o -lgcc

indent:
	indent init_main.c 
	indent subr_cons.c 
	@rm -f *.BAK


.PHONY: all grub indent
