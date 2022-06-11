include ../config.mk

#all:
#	$(CC) $(CFLAGS) -D $(ARCH) -I ../include -c subr_cons.c -o $(OBJDIR)/cons.o
#	$(CC) $(CFLAGS) -I ../include -c init_main.c -o $(OBJDIR)/init_main.o
#	$(CC) $(CFLAGS) -T ../arch/$(ARCH)/boot/kern.ld -o $(OBJDIR)/kernel -ffreestanding -nostdlib $(OBJDIR)/cons.o $(OBJDIR)/cpu_console.o $(OBJDIR)/cpu.o $(OBJDIR)/init_main.o $(OBJDIR)/entry.o -lgcc


all:
	$(CC) $(CFLAGS) -D $(ARCH) -I ../include -c subr_cons.c -o $(OBJDIR)/cons.o
	$(CC) $(CFLAGS) -I ../include -c init_main.c -o $(OBJDIR)/init_main.o
	$(LD) -o $(OBJDIR)/kernel -Ttext 0x1000 $(OBJDIR)/cons.o $(OBJDIR)/cpu_console.o $(OBJDIR)/cpu.o $(OBJDIR)/init_main.o --oformat binary


indent:
	indent init_main.c 
	indent subr_cons.c 
	@rm -f *.BAK


.PHONY: all indent
