#include <console.h>

extern void	HLT(void);

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
		HLT();
	}

	/* NOTREACHED */
}
