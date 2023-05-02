#include "CPU228.cpu"

    ; load addressing mode testing
    nop
    ld r0, directTest               ; direct
    ld r0, #420                     ; immediate
    ld r0, (indirectPointer)        ; indirect
    ld r1, #3                       ; direct indexed setup
    ld r0, directTest[r1]           ; direct indexed
    ld r0, indirectTest[r1]         ; indirect indexed
    ld r0, r1                       ; register
    ld r1, #registerIndirectTest    ; register indirect setup
    ld r0, (r1)                     ; register indirect

stop:
    jmp stop

directTest:
#d16 729
#d16 0
#d16 0
#d16 829

indirectPointer:
#d16 indirectTest

indirectTest:
#d16 1776
#d16 0
#d16 0
#d16 921

registerIndirectTest:
#d16 523