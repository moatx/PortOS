#include <console.h>
#include <stdarg.h>
#include <stdint.h>

extern void cpu_consinit(void);
extern void disable_cursor(void);
extern void enable_cursor(uint8_t cursor_start, uint8_t cursor_end);
extern void update_cursor(int y, int x);
extern void write_char(char c, int color, unsigned int y, unsigned int x);

void vprintf(const char *str, int color /* , va_list ap */ );

unsigned int y = 0;
unsigned int x = 0;

void
consinit(void)
{
	/* restart the cursor */
	disable_cursor();
	/*
	enable_cursor(0, 0);
	update_cursor(y, x);
	*/
	cpu_consinit();
	enable_cursor(0, 0);
}
/* TODO: add va support */
void
printf(const char *fmt /* , ... */ )
{
	/* va_list ap; va_start(ap, fmt); */
	vprintf(fmt, 0x07 /* , ap */ );
	/* va_end(ap); */

}

void
vprintf(const char *str, int color /* , va_list ap */ )
{
	unsigned int l = 0;
	while (str[l] != '\0') {
		if (str[l] == '\n') {
			++y;
		}
		write_char(str[l], color, y, x);
		++l;
	}
	x = 0;
	/*update_cursor(y, x);*/
}
