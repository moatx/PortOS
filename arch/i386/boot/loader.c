/*	$BASE style.c,v 0.0 2021/07/10 02:00:34 moatx Exp $		*/

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

#include <cpu.h>

/*
 * elf loader
 */ 

struct elf {

	/*uint32_t*/
        int e_magic;	
        /*
	uint8_t e_elf[12];
	uint16_t e_type;
	uint16_t e_machine;
	uint32_t e_version;
	uint32_t e_entry;
	uint32_t e_phoff;
	uint32_t e_shoff;
	uint32_t e_flags;
	uint16_t e_ehsize;
	uint16_t e_phentsize;
	uint16_t e_phnum;
	uint16_t e_shentsize;
	uint16_t e_shnum;
	uint16_t e_shstrndx;
        */
};

#define ELF_MAGIC 0x464C457FU 
#define ELFHDR		((struct elf *)0x10000) 
#define SECTSIZE 512

#define waitdisk() while ((inb(0x1F7) & 0xC0) != 0x40)

void loader(void);
void readsect(void*, int);
void readseg(uint32_t, uint32_t, uint32_t);
void tprint(char *);
/* loads the elf kernel from hard disk */
void
loader(void)
{
  /* read the first page off disk */
  readseg((uint32_t) ELFHDR, SECTSIZE*8, 0);
  
  /* check if theres a elf executable */
  if (ELFHDR->e_magic != ELF_MAGIC)
        return;  /* let bootsect handle the error */
  tprint("its an elf");

  /* a infinite loop to not return */
  for(;;);

  /* NOTREACHED */
}


/*
 * Read 'count' bytes at 'offset' from kernel into virtual address 'va'.
 * Might copy more than asked
 */

void
readseg(uint32_t va, uint32_t count, uint32_t offset)
{
	uint32_t end_va;

	va &= 0xFFFFFF;
	end_va = va + count;
	
	/* round down to sector boundary */
	va &= ~(SECTSIZE - 1);

	/* translate from bytes to sectors, and kernel starts at sector 1 */
	offset = (offset / SECTSIZE) + 1;

	/* XXX If this is too slow, we could read lots of sectors at a time.
	 * We'd write more to memory than asked, but it doesn't matter --
	 * we load in increasing order.
         */

	while (va < end_va) {
		readsect((uint8_t*) va, offset);
		va += SECTSIZE;
		offset++;
	}
}

/* reads a sector */
void
readsect(void *dst, int offset)
{
  /* wait for disk to be ready */
  waitdisk();
  
  /* commands */

  /* set sector count to 1 */

  outb(0x1F2, 1);   /*register 0x1F2 is the sector count register*/

  /* get the block */
  outb(0x1F3, offset);    
  outb(0x1F4, offset >> 8);
  outb(0x1F5, offset >> 16);

  /* sets master drive */
  outb(0x1F6, (offset >> 24) | 0xE0); 
  
  /* read the sector */
  outb(0x1F7, 0x20);	  

  /* wait for disk to be ready */
  waitdisk();
  
  /* read from data register specified by offset into dst */
  insl(0x1F0, dst, SECTSIZE/4);
}

void
tprint(char *str)
{
    volatile char* txt = (volatile char*)0xb8000;
    unsigned char_loc = 0;
    unsigned int b = 0;
    while (str[b] != '\0'){
        txt[char_loc++] = str[b++];
        txt[char_loc++] = 0x07; /* black */
        }

  /* new line */
  char_loc = char_loc + (160 - (char_loc % 160));
}
