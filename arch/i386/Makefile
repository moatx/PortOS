#	$BASE style.c,v 0.0 2021/06/29 02:18:05 moatx Exp $		

include ../../config.mk

boot/bootblock.o: cpu/cpu.o lib/console.o
	$(CC) $(CFLAGS) $(CLFLAGS) -I ./include -c ./boot/loader.c -o ./boot/loader.o
	$(AS) -c ./boot/bootsect.S -o ./boot/bootsect.o
	$(LD) -N -e start -Ttext 0x7C00 -o $@ ./boot/bootsect.o ./boot/loader.o ./cpu/cpu.o ./lib/console.o

cpu/cpu.o: ./cpu/cpu.S
	$(AS) -c ./cpu/cpu.S -o $@

lib/console.o: ./lib/console.c
	$(CC) $(CFLAGS) $(CLFLAGS) -I ./include -c ./lib/console.c -o $@  

.PHONY: clean
clean:
	@rm -f ./*/*.o
