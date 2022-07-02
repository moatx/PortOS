#include <console.h>


const char copyright[] =
"Copyright (c) 2022 moatx. All rights reserved.  github.com/moatx/PortOS \n"
"Welcome to PortOS version 0.0.0 alpha\n";

/* XXX return int, so gcc -Werror won't complain */
int
main(void)
{
	consinit();
	printf(copyright);
	printf("starting init process...");
	/* infinte loop to not return */
	for (;;) {
		/* underline(); */
#if defined(__i386__)
		__asm__("hlt");
#endif
	}

	/* NOTREACHED */
}
