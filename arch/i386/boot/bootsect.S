/*	$BASE style.c,v 0.0 2021/06/29 02:14:11 moatx Exp $		*/

/*
 * Copyright 2021 BASE. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright notice, this
 *    list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHORS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE AUTHORS AND CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

.code16 /* excute code as 16 bit instructions */
.global start 
start: 

  /* clear intruppts and descriptors to not have any problems */

  cli
  cld
  
  movw	$start,%sp         	


/* enable the a20 line for 20th bit */
seta20.1:
  inb     $0x64,%al               /* wait until its not busy */
  testb   $0x2,%al
  jnz     seta20.1

  movb    $0xd1,%al               /* 0xd1 -> port 0x64 */
  outb    %al,$0x64
  jmp seta20.2

seta20.2:
  inb     $0x64,%al               /* Wait until its not busy */
  testb   $0x2,%al
  jnz     seta20.2

  movb    $0xdf,%al               /* 0xdf -> port 0x60 */
  outb    %al,$0x60
  ret


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
start32:
  /* setup 32 bit segment registers */
  movw $10, %ax
  movw %ax, %ds
  movw %ax, %es
  movw %ax, %fs
  movw %ax, %gs
  movw %ax, %ss

  call loader /* Give control to the loader */
  /* should not return but if it does lets have a infinite loop */

plooper:
	jmp plooper

