#	$BASE style.c,v 0.0 2021/06/29 02:18:05 moatx Exp $		

include ../../config.mk

all:
	cd boot && make && cd ..
	cd i386 && make && cd ..

indent:
	cd i386 && make indent && cd ..


.PHONY: all indent
