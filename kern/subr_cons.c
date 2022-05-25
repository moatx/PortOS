#include <console.h>

extern void cpu_consinit(void);
extern void disable_cursor(void);

void
consinit(void)
{
	    /* disable the cursor for now */
	disable_cursor();
	cpu_consinit();
}
