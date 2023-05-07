; Ethan Thummel | Amir Bahmandar | Fabiola Sore 4/28/23

#include "CPU228.cpu"

    ; 4 x 4 matrix multiplication

    nop
    ld r6, #0               ; init r7 with 0, use as row index (A's rows)

row:                        ; loop for each row

    ld r7, #0               ; init r7 with 0, use as collum index (B's collums)

coll:                       ; loop for each collum     

    jsr dotproduct          ; subroutine which calulates the dotproduct

    inc r7                  ; increment the collum index
    cmp r7, #4              ; if its less that 4, then do the next collum loop
    jnz coll

collexit:                   ; when done with a collum             

    inc r6                  ; increment the row index
    cmp r6, #4              ; if its less than 4, the do the nex row loop
    jnz row

rowexit:

    ld r0, C0
    ld r0, C0+1
    ld r0, C0+2
    ld r0, C0+3
    ld r0, C0+4
    ld r0, C0+5
    ld r0, C0+6
    ld r0, C0+7
    ld r0, C0+8
    ld r0, C0+9
    ld r0, C0+10
    ld r0, C0+11
    ld r0, C0+12
    ld r0, C0+13
    ld r0, C0+14
    ld r0, C0+15

programend:                 ; infinite loop at the end of the program
    jmp programend

dotproduct:

    ld r5, #0               ; dotproduct index
    ld r2, #0               ; reset dotproduct total

.loop:

                            ; first, load r3 with the "thing" from A
    ld r3, APointers[r6]    ; load the pointer at APointers + row index
    add r3, r5              ; add the dotproduct index to that pointer
    ld r3, (r3)             ; load r3 with the memory pointed to by r3

                            ; second, load r4 with the "thing" from B0
    ld r4, BPointers[r5]    ; load the pointer at BPointers + dotproduct index
    add r4, r7              ; add the collum index to that pointer
    ld r4, (r4)             ; load r4 with the memory pointed to by r4

                            ; now do the math
    mul r3, r4              ; A X B
    add r2, r3              ; increment running total by r3   

    inc r5                  ; increment the dotproduct index
    cmp r5, #4              ; if the dotproduct index is less than 3, the do the next dotproduct loop
    jnz .loop

.exit:

    ld r3, CPointers[r6]    ; load r3 with the row pointer specified by the row index
    add r3, r7              ; add the collum index to the pointer
    st (r3), r2             ; store the dotproduct result for that cell into C
    rts                     ; return from the dotproduct subroutine

APointers:
#d16 A0, A1, A2, A3 
A0:
#d16 18, -14, -8, 5
A1:
#d16 -6, 13, 18, 8
A2:
#d16 -17, 20, -19, -19
A3:
#d16 -11, 12, 12, -3

BPointers:
#d16 B0, B1, B2, B3
B0:
#d16 9, 0, 1, -8
B1:
#d16 1, -2, -1, 6
B2:
#d16 9, 9, -7, 0
B3:
#d16 -2, 5, -10, -3

CPointers:
#d16 C0, C1, C2, C3
C0:
#d16 0, 0, 0, 0
C1:
#d16 0, 0, 0, 0
C2:
#d16 0, 0, 0, 0
C3:
#d16 0, 0, 0, 0

#addr 0x0fff
end:
#d16 0