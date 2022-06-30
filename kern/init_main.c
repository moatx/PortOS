#include <console.h>

extern void HLT(void);

/* XXX return int, so gcc -Werror won't complain */
int
main(void)
{
	const char *welcome = "Welcome to PortOS!";
	consinit();
	printf("starting init process...\n");
	printf(welcome);
	/* infinte loop to not return */
	for (;;) {
		underline();
#if defined(__i386__)
		__asm__("hlt");
#endif
	}

	/* NOTREACHED */
}
