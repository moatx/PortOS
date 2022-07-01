#ifndef _I386_ASM_H_
#define _I386_ASM_H_

/*
#define _ENTRY(x) \
	.text; _ALIGN_TEXT; .globl x; .type x,@function; x:
*/
#define _C_LABEL(name)	name

#define _ENTRY(x) \
	.text; .globl x; .type x,@function; x:

#define	ENTRY(y)	_ENTRY(_C_LABEL(y));	/* _PROF_PROLOGUE */


#endif				/* !_I386_ASM_H_ */
