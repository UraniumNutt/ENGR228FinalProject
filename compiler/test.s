#include "CPU228.cpu"

    ; simple addition program
    ld r0, #14
    add r0, #28
    st r1, r0
stop:
    jmp stop