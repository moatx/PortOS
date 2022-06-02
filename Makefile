#	$BASE style.c,v 0.0 2021/06/29 02:17:36 moatx Exp $		

include config.mk

all: 
	dd if=/dev/zero of=PortOS.img count=10000
	dd if=$(OBJDIR)/bootblock of=PortOS.img conv=notrunc
	dd if=$(OBJDIR)/kernel of=PortOS.img seek=1 conv=notrunc


indent:
	cd ./arch/i386 && make indent && cd ../..
	cd ./kern && make indent && cd ..

test:
	./build.sh i386
	qemu-system-i386                                 \
  	-no-reboot                                     \
    	-serial stdio                                  \
  	-drive format=raw,file=PortOS.img 	

.PHONY: clean all knfmt test
clean:
	@rm -f PortOS.img
