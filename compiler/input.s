#include "CPU228.cpu"

    ; load addressing mode testing
    nop
    ld r0, #0
loop:
    inc r0
    jp loop

endprog:
    jmp endprog

#addr 0x1000
end:
#d16 0

