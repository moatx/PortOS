include ../config.mk

all:
	$(CC) $(CFLAGS) -I ../include -c subr_cons.c -o $(OBJDIR)/cons.o
	$(CC) $(CFLAGS) -I ../include -c init_main.c -o $(OBJDIR)/init_main.o
	$(LD) -o $(OBJDIR)/kernel -Ttext 0x1000 $(OBJDIR)/cons.o $(OBJDIR)/cpu_console.o $(OBJDIR)/cpu.o $(OBJDIR)/init_main.o --oformat binary


.PHONY: clean all

clean:
	@rm -f *.o
