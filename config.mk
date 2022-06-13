HEAD := "$(PWD)"

TOOLPREFIX := i386-elf-

CC := $(TOOLPREFIX)gcc
AS := $(TOOLPREFIX)as
LD := $(TOOLPREFIX)ld
AR := $(TOOLPREFIX)ar

OBJCOPY := $(TOOLPREFIX)objcopy
OBJDUMP := $(TOOLPREFIX)objdump

CFLAGS := -O3 --std=c90 -pedantic  -nostdinc -ansi -lgcc -Wall -Wextra -Werror -Wstrict-prototypes -Wold-style-definition -Wmissing-prototypes -Wmissing-declarations -Wdeclaration-after-statement -ffreestanding -Wduplicated-cond  -Wduplicated-branches  -Wlogical-op  -Wrestrict  -Wnull-dereference  -Wjump-misses-init  -Wdouble-promotion  -Wshadow -Wfloat-equal -Wundef  -Wstrict-prototypes -Wold-style-definition -Wmissing-prototypes -Wmissing-declarations  -Wdeclaration-after-statement -Wno-deprecated-declarations 
