/* XXX: This boot-loader shall not use the stack */
.set KOFFSET, 0x1000

.code16 /* excute code as 16 bit instructions */

.global _start 
_start: 
  /* remember boot drive */
  mov %dl, BOOT_DRIVE 

  /* clear interuppts and descriptors to not have any problems */
  cli
  cld

  /* set segment registers to 0 */
  xorw    %ax,%ax             
  movw    %ax,%ds             
  movw    %ax,%es             
  movw    %ax,%ss             

  mov $MSG_REAL_LOADED, %bx
  call rprint

/* enable the a20 line for 20th bit */
seta20:
	mov $MSG_CHECK_A201, %bx
	call rprint
	
	call wait_kbd
	
	movb    $0xd1, %al               /* 0xd1 -> port 0x64 */
	outb    %al, $0x64		   /* set command write to keyboard controller bit 1 */
	
	call wait_kbd
	
	movb    $0xdf, %al               /* 0xdf -> port 0x60 */
	outb    %al, $0x60		    /* enable A20 line */

load_kernel:
	mov $0x1000, %bx
        mov $16, %dh
        mov (BOOT_DRIVE), %dl
        call disk_load

jump2protected:

 /* load gdt for protected mode */
  lgdt gdtdescr
  mov $MSG_CHECK_GDT, %bx
  call rprint

  /* this bit needs to be switched on to go to 32 bit protected mode */
  movl %cr0, %eax
  orl $0x1, %eax
  movl %eax, %cr0


  /* finnaly long jump into a label in 32 bit protected mode to reload %cs and %eip (inscrution pointer) */
  ljmp $0x08, $_start32 /* 0x08 is gdt code segment */

  mov $MSG_ERROR_JUMP, %bx
  call rprint

  /* should not return but if it does lets have a infinite loop */
  jmp .



.code32
DATA_SEG: .long (gdt_data - gdt_start)
_start32:

  /* setup 32 bit segment registers */
  movw DATA_SEG, %ax
  movw %ax, %ds
  movw %ax, %es
  movw %ax, %fs
  movw %ax, %gs
  movw %ax, %ss

  mov $0x90000, %ebp
  mov %ebp, %esp


  call KOFFSET

  /* should not return but if it does lets have a infinite loop */
  jmp .



.code16

/* GDT */
gdt_start:
gdt_null:
    .long 0x0
    .long 0x0
gdt_code:
    .word 0xffff
    .word 0x0
    .byte 0x0
    .byte 0b10011010
    .byte 0b11001111
    .byte 0x0
gdt_data:
    .word 0xffff
    .word 0x0
    .byte 0x0
    .byte 0b10010010
    .byte 0b11001111
    .byte 0x0
gdt_end:
gdtdescr:
    .word gdt_end - gdt_start
    .long gdt_start
.set CODE_SEG, gdt_code - gdt_start

/* FUNCTIONS */
wait_kbd:
	nop
    	inb $0x64, %al	/* wait until its not busy */
    	testb $0x2, %al
    	jnz wait_kbd
    	ret

disk_load:
        mov $0x02, %ah
        mov %dh, %al
	mov $0x02, %cl
	mov $0x00, %ch
	mov $0x00, %dh
	int $0x13
	ret

/* real mode print */
rprint:
	mov $0x0e, %ah
	1: 
		mov (%bx), %al
		
		cmp $0, %al
		je 1f
		
		int $0x10
		add $1, %bx
		jmp 1b
	1:
	ret

	
	
/* VARIABLES */
BOOT_DRIVE: .byte 0

/* MESSAGES */
MSG_REAL_LOADED: .asciz "loaded in 16 bit real mode \n \r"

MSG_CHECK_A201: .asciz "in A201 \n \r"
MSG_CHECK_A202: .asciz "in A202 \n \r"
MSG_CHECK_GDT:	.asciz "loaded the gdt \n \r"
MSG_CHECK_LOAD: .asciz "in load_kernel \n \r"

MSG_ERROR_JUMP: .asciz "ERROR: did not jump to protected mode \n \r"

.fill (510-(.-_start)) /* fill 510 bytes with 0s */
BIOS_NUMBER: .word 0xAA55 /* BIOS MAGIC NUMBER */

