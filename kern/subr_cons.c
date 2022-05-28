#include <console.h>

extern void cpu_consinit(void);
extern void disable_cursor(void);
extern void write_char(const char* str, int color);

void
consinit(void)
{
	/* disable the cursor for now */
	disable_cursor();
	cpu_consinit();
}


/* dputs is puts but for debugging */
void
dputs(const char* str)
{
	write_char(str,0x07);
}
