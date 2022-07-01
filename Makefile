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
	make -C include indent
	make -C kern indent
	make -C arch/i386 indent

test:
	./build.sh i386
	qemu-system-i386 -s\
    	-serial stdio \
  	-drive format=raw,file=PortOS.bin &

test-grub:
	./build.sh -g i386
	qemu-system-i386 -s PortOS.iso

update:
	#git submodule foreach git pull
	git submodule update --recursive --remote
#splint init_main.c -I ../include/ -strict -nolib -namechecks
#clang -Weverything init_main.c  -I ../include/ $CFLAGS -Di386 -ferror-limit=80
.PHONY: all bin img indent test clean update
clean:
	@rm -f PortOS.img PortOS.bin PortOS.iso
	#@rm -rf sboot
