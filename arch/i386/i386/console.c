#include <console.h>
#include <cpu.h>

#define VGA_WIDTH 80
#define cons_buf (volatile char*)0xB8000
#define black 0x07
#define newline() (char_loc = char_loc + (160 - (char_loc % 160))) /* 160 is the line size (the result of 80 collums * element and each element takes 2 bytes (bytes for each elements)); line size - char location % line size (to find the length) + char location */

unsigned int char_loc = 0; /* the reason why this is global is because if its local all the stored data will be lost when the function returns, and that means it'll print the new char in the same place the old char is not next to it */

void 
cpu_consinit(void)
{
    int j = 0;
    volatile char* txt = cons_buf;

    /* disable the cursor for now */
    outb(0x3D4, 0x0A);
    outb(0x3D5, 0x20);

    /* there are 25 lines each of 80 columns; each element takes 2 bytes */
    while(j < 80 * 25 * 2) {
        txt[j] = ' ';
        txt[j+1] = black; 		
        j = j + 2;
}
}
/*
void
write_char(uint8_t ch, uint8_t color, int x, int y)
{
    volatile char* txt = cons_buf + (y * 80 + x);

}
*/
