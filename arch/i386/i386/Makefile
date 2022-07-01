include ../../../config.mk

all:
	$(AS) -I ../include -c cpu.S -o $(OBJDIR)/cpu.o
	$(CC) $(CFLAGS) -D $(ARCH) -I ../include -I ../../../include -c console.c -o $(OBJDIR)/cpu_console.o
	$(CC) $(CFLAGS) -D $(ARCH) -I ../include -I ../../../include -c i386.c -o $(OBJDIR)/i386.o
indent:
	indent console.c
	indent i386.c
	@rm -f *.BAK


.PHONY: all indent
