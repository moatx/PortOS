#HEAD := "$(PWD)"

TOOLPREFIX := i386-elf-
#TOOLPREFIXA := i386-elf-
#TOOLPREFIX := clang -target i386-elf -march=i386 -Weverything

CC := $(TOOLPREFIX)gcc
AS := $(TOOLPREFIX)as
LD := $(TOOLPREFIX)ld
AR := $(TOOLPREFIX)ar

#CC := $(TOOLPREFIX)
#AS := $(TOOLPREFIXA)as
#LD := $(TOOLPREFIXA)ld
#AR := $(TOOLPREFIXA)ar

OBJCOPY := $(TOOLPREFIX)objcopy
OBJDUMP := $(TOOLPREFIX)objdump

CFLAGS := -O2 -g --std=c90 -W -pedantic  -nostdinc -ansi -lgcc -Wall -Wextra -Werror -Wstrict-prototypes -Wold-style-definition -Wmissing-prototypes -Wmissing-declarations -Wdeclaration-after-statement -ffreestanding -Wduplicated-cond  -Wduplicated-branches  -Wlogical-op  -Wrestrict  -Wnull-dereference  -Wjump-misses-init  -Wdouble-promotion  -Wshadow -Wfloat-equal -Wundef  -Wstrict-prototypes -Wold-style-definition -Wmissing-prototypes -Wmissing-declarations  -Wdeclaration-after-statement -Wno-deprecated-declarations 
#CFLAGS := -O2 -g --std=c90 -pedantic  -nostdinc -ansi -Wall -Wextra -Werror -Wstrict-prototypes -Wold-style-definition -Wmissing-prototypes -Wmissing-declarations -Wdeclaration-after-statement -ffreestanding -Wnull-dereference  -Wdouble-promotion  -Wshadow -Wfloat-equal -Wundef  -Wstrict-prototypes -Wold-style-definition -Wmissing-prototypes -Wmissing-declarations  -Wdeclaration-after-statement -Wno-deprecated-declarations 
