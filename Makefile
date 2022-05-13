#	$BASE style.c,v 0.0 2021/06/29 02:17:36 moatx Exp $		

include config.mk

base.img: bootblock kernel
	dd if=/dev/zero of=base.img count=10000
	dd if=bootblock of=base.img conv=notrunc
	dd if=kernel of=base.img seek=1 conv=notrunc

bootblock: ./arch/i386/boot/boot.S 
	cd ./arch/i386 && make && cd ../../
	$(OBJCOPY) -S -O binary ./arch/i386/boot/bootblock.o $@
	sh sign.sh $@

kernel:
	cd ./kern/ && make && cd ..
	$(AS) -c ./arch/i386/init/kernel_entry.S -o ./kern/kernel_entry.o
	$(LD) -o $@ -Ttext 0x1000 ./kern/*.o --oformat binary


.PHONY: clean 
clean:
	@cd ./arch/i386 && make clean && cd ../../
	@cd ./kern && make clean && cd ../../
	@rm -f base.img bootblock kernel
