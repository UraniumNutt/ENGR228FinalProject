// Ethan Thummel | Amir Bahmandar | Fabiola Sore 4/19/23

`timescale 1ns / 1ps

module ALU(

    input clk,
    input [15:0] A,
    input [15:0] B,
    input [4:0] functionSelect,
    input [3:0] overwriteFlagsMask,
    input updateFlags,
    input [3:0] setFlagBits, // carry zero pos neg
    output [15:0] result,
    output [3:0] FlagBits    // carry zero pos neg
    
    );

    reg [3:0] currentFlags;
    initial currentFlags = 4'b0100;


    always @(functionSelect) begin
        
        case (functionSelect)
            
            5'b00000: result = A;
            5'b00001: result = A + B + currentFlags[3];  // add carry flag
            5'b00010: result = A + B;
            5'b00011: result = A - B - ~currentFlags[3]; // carry acts as a reverse borrow
            5'b00100: result = A - B;
            5'b00101: result = (A * B)[15:0];            // truncate
            5'b00110: result = A + 1;
            5'b00111: result = A - 1;
            5'b01000: result = ~A + 1;
            5'b01001: result = A & B;
            5'b01010: result = A | B;
            5'b01011: result = ~A;
            5'b01100: result = A ^ B;
            5'b01101: result = A << 1;
            5'b01110: result = A >> 1;
            5'b01111: result = A << B;
            5'b10000: result = A >> B;
            5'b10001: result = {(A << 1)[15:1], A[15]};   // to finish
            5'b10010: result = {A[0], (A >> 1)[14:0]};    // to finish
            5'b10011: result = 0;                         // to finish
            5'b10100: result = 0;                         // to finish
            5'b10101: result = A - B;                     // to finish, is this how this should work?
            5'b10110: result = A * B;               


            default: result = 0;

        endcase

    end


endmodule
