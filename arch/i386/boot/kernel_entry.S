.code32
.extern main 
call main
/* main shouldnt return but if it does loop */
jmp .
