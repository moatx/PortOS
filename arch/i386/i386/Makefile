include ../../../config.mk

all:
	$(AS) -c cpu.S -o $(OBJDIR)/cpu.o
	$(CC) $(CFLAGS) -D ${CPU} -I ../include -I ../../../include -c console.c -o $(OBJDIR)/cpu_console.o


