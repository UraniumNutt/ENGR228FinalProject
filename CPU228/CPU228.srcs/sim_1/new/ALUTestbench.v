// Ethan Thummel | Amir Bahmandar | Fabiola Sore 4/24/23

`timescale 1ns / 1ps

module ALUTestbench;

    reg clk;
    reg signed [15:0] A;
    reg signed [15:0] B;
    reg [4:0] functionSelect;
    reg [4:0] overwriteFlagsMask;
    reg [4:0] setFlagBits; // carry overflow zero pos neg
    wire signed [15:0] result;
    wire [4:0] currentFlags;    // carry overflow zero pos neg

    ArithmeticLogicUnit uut(

        .clk(clk),
        .A(A),
        .B(B),
        .functionSelect(functionSelect),
        .overwriteFlagsMask(overwriteFlagsMask),
        .setFlagBits(setFlagBits),
        .result(result),
        .currentFlags(currentFlags)

    );

    // NOTE: need more thoroughly check if flags are being set correctly
    // I know for a fact that the mul instruction is not setting its flags correctly
    // OK now I think it is working

    initial begin

        // A = 14; B = 28; functionSelect = 1; 
        // #10 clk = 1; #10 clk = 0;

        // #10 functionSelect = 17; overwriteFlagsMask = 5'b11111; setFlagBits = 5'b00100;
        // #10 clk = 1; #10 clk = 0;

        // overwriteFlagsMask = 5'b11111; setFlagBits = 5'b00000;
        // #10 clk = 1; #10 clk = 0;

        // A = 42; B = 28; functionSelect = 3; 
        // #10 clk = 1; #10 clk = 0;

        // A = 7; B = 89; functionSelect = 5;
        // #10 clk = 1; #10 clk = 0;

        // #10 functionSelect = 17; overwriteFlagsMask = 5'b11111; setFlagBits = 5'b00000;
        // #10 clk = 1; #10 clk = 0;

        // A = 42; B = 50; functionSelect = 3; 
        // #10 clk = 1; #10 clk = 0;

        // #10 functionSelect = 17; overwriteFlagsMask = 5'b11111; setFlagBits = 5'b00000;
        // #10 clk = 1; #10 clk = 0;

        // A = -53; B = -72; functionSelect = 1;
        // #10 clk = 1; #10 clk = 0;

        // #10 functionSelect = 17; overwriteFlagsMask = 5'b11111; setFlagBits = 5'b00000;
        // #10 clk = 1; #10 clk = 0;

        #10 functionSelect = 17; overwriteFlagsMask = 5'b11111; setFlagBits = 5'b00000;
        
        #10 A = 256; B = 512; functionSelect = 5;
        #10 clk = 1; #10 clk = 0;        
        
        // #10 functionSelect = 17; overwriteFlagsMask = 5'b11111; setFlagBits = 5'b00000;
        // A = 42; functionSelect = 8;
        // #10 clk = 1; #10 clk = 0;        

        // #10 functionSelect = 17; overwriteFlagsMask = 5'b11111; setFlagBits = 5'b00000;
        // A = 42; functionSelect = 6;
        // #10 clk = 1; #10 clk = 0;        

        // #10 functionSelect = 17; overwriteFlagsMask = 5'b11111; setFlagBits = 5'b00000;
        // A = 42; functionSelect = 7;
        // #10 clk = 1; #10 clk = 0;           

        // #10 functionSelect = 17; overwriteFlagsMask = 5'b11111; setFlagBits = 5'b00000;
        // A = 42; functionSelect = 13;
        // #10 clk = 1; #10 clk = 0;  

        // #10 functionSelect = 17; overwriteFlagsMask = 5'b11111; setFlagBits = 5'b00000;
        // A = 42; functionSelect = 14;
        // #10 clk = 1; #10 clk = 0;  

        // #10 functionSelect = 17; overwriteFlagsMask = 5'b11111; setFlagBits = 5'b00000;
        // A = 42; B = 3; functionSelect = 9;
        // #10 clk = 1; #10 clk = 0;  
        

    end

endmodule
