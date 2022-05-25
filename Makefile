#	$BASE style.c,v 0.0 2021/06/29 02:17:36 moatx Exp $		

include config.mk

PortOS.img: 
	dd if=/dev/zero of=PortOS.img count=10000
	dd if=$(OBJDIR)/bootblock of=PortOS.img conv=notrunc
	dd if=$(OBJDIR)/kernel of=PortOS.img seek=1 conv=notrunc

#bootblock: ./arch/i386/boot/boot.S 
#	cd ./arch/i386 && make && cd ../../
#	$(OBJCOPY) -S -O binary ./arch/i386/boot/bootblock.o $@
#	sh sign.sh $@
#
#kernel:
#	cd ./kern/ && make && cd ..
#	$(AS) -c ./arch/i386/boot/kernel_entry.S -o ./kern/kernel_entry.o
#	$(LD) -o $@ -Ttext 0x1000 ./kern/*.o --oformat binary


.PHONY: clean 

#clean:
#	@cd ./arch/i386 && make clean && cd ../../
#	@cd ./kern && make clean && cd ../../
#	@rm -f base.img bootblock kernel

clean:
	@rm -f PortOS.img
