#include "CPU228.cpu"

    ; load addressing mode testing
    nop
    ld r2, #0
    ld r3, #0
waitLong:
    inc r2
    jnn waitLong
    ld r2, #0
    inc r3
    jnn waitLong
    
    ld r1, #0
loop:
    ld r0, message[r1]
    jz exit
waitTx:
    jtf waitTx
    tra r0
    inc r1
    jmp loop

exit:
    jmp exit

message:
    #d "Hello, World!\0"

#addr 0x0fff
end:
#d16 0

