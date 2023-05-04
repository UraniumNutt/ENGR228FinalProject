#include "CPU228.cpu"

    ; load addressing mode testing
    nop
    ld r0, foo
    ld r0, #721
    ld r0, (thing1)
    ld r1, #1
    ld r0, foo[r1]
    ld r0, (thing1)[r1]
    ld r3, #420
    ld r0, r3
    ld r2, #idkanymore
    ld r0, (r2)

    ld r1, #6502
    st idkanymore, r1
    ld r0, idkanymore

    ref r0

loop:
    jmp loop

#addr 0x0100
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

#addr 0x3fff
end:
#d16 0

