#include "CPU228.cpu"

    ; load addressing mode testing
    nop
    ld r0, #14
    ld r1, #foo
    add r0, (r1)
    
    

stop:
    jmp stop

foopointer:
#d16 foo

foo:
#d16 28
#d16 28

#addr 0x3fff
end:
#d16 0

