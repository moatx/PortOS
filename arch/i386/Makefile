#	$BASE style.c,v 0.0 2021/06/29 02:18:05 moatx Exp $		

include ../../config.mk

boot/bootblock.o: 
	$(AS) -I ./include -c ./boot/boot.S -o ./boot/boot.o
	$(LD) -N -e _start -Ttext 0x7C00 -o $@ ./boot/boot.o 




.PHONY: clean
clean:
	@rm -f ./*/*.o
