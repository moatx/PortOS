.code32
.extern main 

movl $0x07690748,0xb8000

call main

/* main shouldnt return but if it does loop */
jmp .
