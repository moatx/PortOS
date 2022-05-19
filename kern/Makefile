include ../config.mk

all:
	$(CC) $(CFLAGS) -I ../include -c subr_cons.c -o ../compile/cons.o
	$(CC) $(CFLAGS) -I ../include -c init_main.c -o ../compile/init_main.o
	$(LD) -o ../compile/kernel -Ttext 0x1000 ../compile/cons.o ../compile/cpu_console.o ../compile/cpu.o ../compile/init_main.o --oformat binary


.PHONY: clean all

clean:
	@rm -f *.o
