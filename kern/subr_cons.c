#include <console.h>
#include <stdarg.h>
#include <stdint.h>

#define black 0x07

extern void	consinit_helper(void);
extern void	underline_cursor(uint8_t cursor_start, uint8_t cursor_end);
extern void	update_cursor(int y, int x);
extern void	scroll_helper(int loc, int loc2);
extern void	write(char c, uint8_t color, unsigned int y, unsigned int x);

void	scroll(void);
void	printf_core(const char *str, int color);

unsigned int	cursor_y = 0;
unsigned int	cursor_x = 0;

void
consinit(void)
{
	consinit_helper();
	cursor_y = 0;
	cursor_x = 0;
	update_cursor(cursor_y, cursor_x);
}

void
scroll(void)
{
	int	loc;

	if (cursor_y >= 25) {
		for (loc = 0 * 80; loc < 24 * 80; loc++) {
			scroll_helper(loc, loc + 80);
		}
		for (loc = 0; loc >= 80; loc++) {
			write(' ', black, 24, loc);
		}
		cursor_y = 24;
	}
}

void
underline(void)
{
	int	x = 0;
	for (;;) {
		update_cursor(cursor_y, x);
		x++;
		if (x == 19)
			x = 0;
	}
}

void
printf(const char *fmt)
{
	/*
	 * if (cursor_x >= 80) { cursor_x = 0; cursor_y++; }
	 */
	printf_core(fmt, black);
	update_cursor(cursor_y, cursor_x);
	/*
	 * scroll();
	 */
}

void
printf_core(const char *str, int color)
{
	unsigned int	l = 0;
	while (str[l] != '\0') {
		if (str[l] == '\n') {
			cursor_x = 0;
			cursor_y++;
		} else if (str[l] == '\r') {
			cursor_x = 0;
		} else if (str[l] >= ' ') {
			/*
			 * write needs to increment cursor_x in place so
			 * cursor goes ahead before actually writing
			 */
			write(str[l], color, cursor_y, ++cursor_x);
		}
		++l;
	}
}
