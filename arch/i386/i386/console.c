#include <cpu.h>
#include <cstdint.h>
#include <stdint.h>

#define cons_buf (volatile char*)0xB8000
#define black 0x07
#define MAX_ROWS 25
#define MAX_COLS 80

void cpu_consinit(void);
void disable_cursor(void);
void enable_cursor(uint8_t, uint8_t);
void update_cursor(int y, int x);
void write_char(char, int, unsigned int, unsigned int);

static unsigned int char_loc = 0;

void
cpu_consinit(void)
{
	int j = 0;
	volatile char *txt = cons_buf;

    /* there are 25 lines each of 80 columns; each element takes 2 bytes */
	while (j < MAX_COLS * MAX_ROWS * 2) {
		txt[j] = ' ';
		txt[j + 1] = black;
		j = j + 2;
	}
}

void
disable_cursor(void)
{
	outb(0x3D4, 0x0A);
	outb(0x3D5, 0x20);
}

void
enable_cursor(uint8_t cursor_start, uint8_t cursor_end)
{
	outb(0x3D4, 0x0A);
	outb(0x3D5, (inb(0x3D5) & 0xC0) | cursor_start);

	outb(0x3D4, 0x0B);
	outb(0x3D5, (inb(0x3D5) & 0xE0) | cursor_end);
}

void
update_cursor(int y, int x)
{
	uint16_t cursorLocation = y * 80 + x;
	outb(0x3D4, 14);
	outb(0x3D5, cursorLocation >> 8);
	outb(0x3D4, 15);
	outb(0x3D5, cursorLocation);
}

/* WIP */
/*
void
write_char(const char* str, int color, int y, int x)
{
    volatile char* txt = cons_buf + (y * 80 + x);
    unsigned int f = 0;
    unsigned int l = 0;
    while (str[f] != '\0'){
    txt[l++] = str[f];
    txt[l++] = color;
    ++f;
    }
}
*/

void
write_char(char c, int color, unsigned int y, unsigned int x)
{
	volatile char *txt = cons_buf + (y * 80 + x);
	if (c == '\n')
		char_loc = char_loc + (160 - (char_loc % 160));

	txt[char_loc++] = c;
	txt[char_loc++] = color;
}
