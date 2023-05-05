#include "CPU228.cpu"

    ; load addressing mode testing
    nop
    
loop:
    jmp loop

#addr 0x00f0
foo:
#d16 72
#d16 7234

thing1:
#d16 thing2

thing2:
#d16 587
#d16 9812

idkanymore:
#d16 1001

#addr 0x1000
end:
#d16 0

