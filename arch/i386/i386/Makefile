include ../../../config.mk

all:
	$(AS) -c cpu.S -o $(OBJDIR)/cpu.o
	$(CC) $(CFLAGS) -D $(ARCH) -I ../include -I ../../../include -c console.c -o $(OBJDIR)/cpu_console.o
indent:
	indent console.c
	@rm -f *.BAK


.PHONY: all indent
