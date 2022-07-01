#ifndef _STDINT_H_
#define _STDINT_H_

#ifdef i386
#include "../arch/i386/include/int_types.h"
#endif				/* i386 */

typedef __int8_t int8_t;
typedef __uint8_t uint8_t;
typedef __int16_t int16_t;
typedef __uint16_t uint16_t;
typedef __int32_t int32_t;
typedef __uint32_t uint32_t;
#endif
