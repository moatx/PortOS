/*	$BASE style.c,v 0.0 2021/07/10 02:10:36 moatx Exp $		*/

/*
 * Copyright 2021 BASE. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright notice, this
 *    list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHORS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE AUTHORS AND CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */



.section .text
.global outb
.global inb
.global insl

outb:
  push   %ebp
  mov    %esp, %ebp
  mov    0x8(%ebp), %edx
  mov    0xc(%ebp), %al
  out    %al, %dx
  pop    %ebp
  ret

inb:
  push   %ebp
  mov    %esp, %ebp
  mov    0x8(%ebp), %edx
  in     %dx, %al
  pop    %ebp
  ret

insl:
  push   %ebp
  mov    %esp,%ebp
  mov    0xc(%ebp),%edi
  mov    0x10(%ebp),%ecx
  mov    0x8(%ebp),%edx
  cld
  repnz insl (%dx),%es:(%edi)
  ret
