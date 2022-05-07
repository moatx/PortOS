#ifndef _ASM_H_
#define _ASM_H_

#define write pusha ; \
write_loop: \
    mov %bx, %al ; \
    cmp $0, %al ; \
    je write_done ; \
    movb $0x0e, ah ; \
    int $0x10 ; \
    add $1, %bx ; \
    jmp write_loop ; \
write_done: \
    popa ; \
    ret ; \


/*
write_nl:
    pusha
    
    mov $0x0e, %ah
    mov $0x0a, %al; newline char
    int $0x10
    mov $0x0d, %al; carriage return
    int $0x10
    
    popa
    ret
*/

#endif 


