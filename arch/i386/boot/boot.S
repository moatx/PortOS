.set KOFFSET, 0x1000

.code16 /* excute code as 16 bit instructions */

.global start 
start: 
  mov %dl, BOOT_DRIVE
  mov %bp, %sp
  call load_kernel
  
  /* clear intruppts and descriptors to not have any problems */
  cli
  cld
  
  movw	$start,%sp         	

	mov $MSG_REAL_LOADED, %bx
	call print_str

call seta20.1
 /* load gdt for protected mode */
  lgdt gdtdescr

  /* this bit needs to be switched on to go to 32 bit protected mode */

  movl %cr0, %eax
  orl $0x1, %eax
  movl %eax, %cr0

  /* finnaly long jump into a label in 32 bit protected mode */
  ljmp $8, $start32

  /* should not return but if it does lets have a infinite loop */
  jmp rlooper

rlooper:
    jmp rlooper


/* enable the a20 line for 20th bit */
seta20.1:
	mov $MSG_CHECK_A201, %bx
	call print_str
  inb     $0x64,%al               /* wait until its not busy */
  testb   $0x2,%al
  jnz     seta20.1

  movb    $0xd1,%al               /* 0xd1 -> port 0x64 */
  outb    %al,$0x64
  jmp seta20.2

seta20.2:
	mov $MSG_CHECK_A202, %bx
	call print_str
  inb     $0x64,%al               /* Wait until its not busy */
  testb   $0x2,%al
  jnz     seta20.2

  movb    $0xdf,%al               /* 0xdf -> port 0x60 */
  outb    %al,$0x60
 ret

  


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

.code32
DATA_SEG: .long (gdt_data - gdt_start)
start32:

  /* setup 32 bit segment registers */
  movw DATA_SEG, %ax
  movw %ax, %ds
  movw %ax, %es
  movw %ax, %fs
  movw %ax, %gs
  movw %ax, %ss

/*
	mov $0x90000, %ebp
	mov %ebp, %esp
*/
  call KOFFSET

  /* should not return but if it does lets have a infinite loop */

plooper:
	jmp plooper


.code16

load_kernel:
        /*pusha*/

	mov $MSG_CHECK_LOAD, %bx
	call print_str

        mov $0x9000, %bx
	mov $5, %dh
        
        mov $0x02, %ah
        mov %dh, %al
	mov $0x02, %cl
	mov $0x00, %ch
	mov $0x00, %dh
	int $0x13
	/*popa*/
	ret

/* not my code */
print_str:
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
MSG_PROTECTED_LOADED: .asciz "loaded in 32 bit protected mode \n \r"
MSG_CHECK_A201: .asciz "in A201 \n \r"
MSG_CHECK_A202: .asciz "in A202 \n \r"
MSG_CHECK_LOAD: .asciz "in load_kernel \n \r"


