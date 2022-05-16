#include <console.h>

/* XXX return int, so gcc -Werror won't complain */
int
main(void) 
{
  /*
   * Attempt to find console and initialize
   * in case of early panic or other messages.
   */
  consinit();

  printf("starting init process \n");

  /* infinte loop to not return */
  for(;;);

  /*NOTREACHED*/
}


