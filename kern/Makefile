include ../config.mk

all:
	$(CC) $(CFLAGS) -I ../arch/i386/include -c ./*.c ../arch/i386/i386/console.c ../arch/i386/i386/cpu.S
	

.PHONY: clean all

clean:
	@rm -f *.o
