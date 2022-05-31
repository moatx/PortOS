include ../../../config.mk

all:
	$(AS) -c cpu.S -o $(OBJDIR)/cpu.o
	$(CC) $(CFLAGS) -D $(ARCH) -I ../include -I ../../../include -c console.c -o $(OBJDIR)/cpu_console.o

indent:
	indent -bap -br -ce -ci4 -cli0 -d0 -di0 -i8 -ip -l79 -nbc -ncdb -ndj -ei -nfc1 -nlp -npcs -psl -sc -sob console.c
	rm *.BAK


.PHONY: all indent
