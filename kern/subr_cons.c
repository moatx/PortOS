#include <console.h>

extern void cpu_consinit(void);

void
consinit(void)
{
	cpu_consinit();
}
