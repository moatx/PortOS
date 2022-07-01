/*
.file	"entry.S"

#include <asm.h>
*/

.code32



/* Declare constants for the multiboot header. */
.set ALIGN,    1<<0             /* align loaded modules on page boundaries */
.set MEMINFO,  1<<1             /* provide memory map */
.set FLAGS,    ALIGN | MEMINFO  /* this is the Multiboot 'flag' field */
.set MAGIC,    0x1BADB002       /* 'magic number' lets bootloader find the header */
.set CHECKSUM, -(MAGIC + FLAGS) /* checksum of above, to prove we are multiboot */

.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM

.section .bss
.align 16
stack_bottom:
.skip 16384 # 16 KiB
stack_top:
 
.section .text
.global entry

.extern init
.extern main 

/*ENTRY(start)*/
entry:
	/* cpu init */
	call init

	mov $stack_top, %esp
	call main

	/* main shouldnt return but if it does loop */
	cli
	1:
		nop
		jmp 1b

.size entry, . - entry
