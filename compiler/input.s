#include "CPU228.cpu"

    ; simple demo program
    nop
    ld r0, #28 ; load r0 with the value 28
    ld r1, #14 ; load r1 with the value 14
    add r0, r1 ; add r0 and r1, store the result in r0

loop:
    jmp loop   ; when done, stall in an infinite loop

#addr 0x0fff   ; make sure to fill all of ram from address 0 - 0x1000
end:
#d16 0

