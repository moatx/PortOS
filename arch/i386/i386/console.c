#include <cpu.h>
#include <stdint.h>

#define cons_buf (uint16_t*)0xB8000

#define black 0x07
#define MAX_ROWS 25		/* lines */
#define MAX_COLS 80

void		consinit_helper(void);
void		underline_cursor(uint8_t cursor_start, uint8_t cursor_end);
void		update_cursor(int y, int x);
void		scroll_helper(int, int);
void		write(char c, uint8_t color, unsigned int y, unsigned int x);

uint16_t       *cons;

void
consinit_helper(void)
{
	int		j = 0;
	cons = cons_buf;

	/* there are 25 lines each of 80 columns; each element takes 2 bytes */
	while (j < MAX_COLS * MAX_ROWS * 2) {
		cons[j] = ' ';
		cons[j + 1] = black;
		j = j + 2;
	}
}

void
underline_cursor(uint8_t cursor_start, uint8_t cursor_end)
{
	outb(0x3D4, 0x0A);
	outb(0x3D5, (inb(0x3D5) & 0xC0) | cursor_start);	/* high */
	outb(0x3D4, 0x0B);
	outb(0x3D5, (inb(0x3D5) & 0xE0) | cursor_end);	/* low */
}

void
update_cursor(int y, int x)
{
	uint16_t	pos = y * MAX_COLS + x;
	outb(0x3D4, 14);
	outb(0x3D5, pos >> 8);	/* high byte */
	outb(0x3D4, 15);
	outb(0x3D5, pos);	/* low byte */
}

void
scroll_helper(int loc, int loc2)
{
	cons[loc] = cons[loc2];
}

void
write(char c, uint8_t color, unsigned int y, unsigned int x)
{
	cons = cons_buf + (y * 80 + x);
	*cons = c | color << 8;
}
