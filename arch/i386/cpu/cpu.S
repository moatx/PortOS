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
