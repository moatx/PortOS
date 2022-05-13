include ../config.mk

all:
	$(CC) $(CFLAGS) -I ../arch/i386/include -c ./*.c ../arch/i386/lib/console.c ../arch/i386/cpu/cpu.S
	

.PHONY: clean all

clean:
	@rm -f *.o
