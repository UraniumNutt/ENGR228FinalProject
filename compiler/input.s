#include "CPU228.cpu"

    ; load addressing mode testing
    nop
    ld r0, #0
loop:
    inc r0
    cmp r0, #3
    jnz loop

endloop:
    jmp endloop

sub:
    ld r0, #101
    rts

#addr 0x0fff
end:
#d16 0

