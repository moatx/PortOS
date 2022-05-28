#include <cpu.h>

#define cons_buf (volatile char*)0xB8000
#define black 0x07

void cpu_consinit(void);
void disable_cursor(void);
void write_char(const char* str, int color);

void 
cpu_consinit(void)
{
    int j = 0;
    volatile char* txt = cons_buf;

    /* there are 25 lines each of 80 columns; each element takes 2 bytes */
    while(j < 80 * 25 * 2) {
        txt[j] = ' ';
        txt[j+1] = black; 		
        j = j + 2;
}
}

void
disable_cursor(void)
{
	outb(0x3D4, 0x0A);
	outb(0x3D5, 0x20);
}

/* WIP */
void
write_char(const char* str, int color)
{
    volatile char* txt = cons_buf; /*+ (y * 80 + x);*/
    unsigned int f = 0;
    unsigned int l = 0;
    while (str[f] != '\0'){
    txt[l++] = str[f];
    txt[l++] = color;
    ++f;
    }
}

