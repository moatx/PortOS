.code32
.extern _main 
call _main
/* main shouldnt return but if it does loop */
jmp .
