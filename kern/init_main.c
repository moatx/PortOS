#include <console.h>

/* XXX return int, so gcc -Werror won't complain */
int
main(void)
{
	consinit();
	printf("starting init process...\n");
	printf("Welcome to PortOS");
	/* infinte loop to not return */
	for (;;)
		;

	/* NOTREACHED */
}
