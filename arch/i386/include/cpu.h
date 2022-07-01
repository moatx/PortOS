#ifndef _CPU_H_
#define _CPU_H_

#include <stdint.h>

extern void outb(int, int);
extern uint8_t inb(int);
/*
extern void insl(int, void *, int);
*/

#endif				/* _CPU_H_ */
