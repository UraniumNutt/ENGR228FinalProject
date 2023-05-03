#include "CPU228.cpu"

    ; load addressing mode testing
    nop
    ld r3, #420
    st store, r3
    ld r0, store

stop:
    jmp stop


store:
#d16 0 