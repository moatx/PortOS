#	$BASE style.c,v 0.0 2021/06/29 02:17:36 moatx Exp $		

include config.mk

all: bin img

bin:
	cat $(OBJDIR)/boot.bin $(OBJDIR)/kernel.bin > PortOS.bin


img: 
	@dd if=/dev/zero of=PortOS.img count=10000 2>/dev/null 1>/dev/null
	@dd if=$(OBJDIR)/boot.bin of=PortOS.img conv=notrunc 2>/dev/null 1>/dev/null
	@dd if=$(OBJDIR)/kernel.bin of=PortOS.img seek=1 conv=notrunc 2>/dev/null 1>/dev/null


indent:
	cd ./arch/i386 && make indent && cd ../..
	cd ./kern && make indent && cd ..

test:
	./build.sh i386
	qemu-system-i386 -s\
    	-serial stdio \
  	-drive format=raw,file=PortOS.bin &
#-no-reboot                                     \

.PHONY: all bin img indent test clean 
clean:
	@rm -f PortOS.img PortOS.bin PortOS.iso
