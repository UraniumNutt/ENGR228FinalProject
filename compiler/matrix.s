; Ethan Thummel | Amir Bahmandar | Fabiola Sore 4/28/23

#include "CPU228.cpu"

    ; matrix multiplication prototype
    ; very rough prototype :)


    ld r6, #0               ; init r7 with 0, use as row index (A's rows)

row:                        ; loop for each row

    ld r7, #0               ; init r7 with 0, use as collum index (B's collums)

coll:                       ; loop for each collum     

    jsr dotproduct          ; subroutine which calulates the dotproduct

    inc r7                  ; increment the collum index
    cmp r7, #3              ; if its less that 3, then do the next collum loop
    jnz coll

collexit:                   ; when done with a collum             

    inc r6                  ; increment the row index
    cmp r6, #3              ; if its less than 3, the do the nex row loop
    jnz row

rowexit:

programend:                 ; infinite loop at the end of the program
    jmp programend

dotproduct:

    ld r5, #0               ; dotproduct index

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
    cmp r5, #3              ; if the dotproduct index is less than 3, the do the next dotproduct loop
    jnz .loop

.exit:

    ld r3, CPointers[r6]    ; load r3 with the row pointer specified by the row index
    add r3, r7              ; add the collum index to the pointer
    st (r3), r2             ; store the dotproduct result for that cell into C
    rts                     ; return from the dotproduct subroutine



; The data structure will probably change for the final version
; The final version should support N X N sizes

APointers:
#d16 A0, A1, A2 
A0:
#d16 1, 5, 9
A1:
#d16 6, 3, 2
A2:
#d16 12, 3, 7

BPointers:
#d16 B0, B1, B2
B0:
#d16 5, 3, 5
B1:
#d16 9, 3, 2
B2:
#d16 2, 3, 4

CPointers:
#d16 C0, C1, C2
C0:
#d16 0, 0, 0
C1:
#d16 0, 0, 0
C2:
#d16 0, 0, 0