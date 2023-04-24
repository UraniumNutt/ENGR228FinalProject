// Ethan Thummel | Amir Bahmandar | Fabiola Sore 4/24/23

`timescale 1ns / 1ps

module ALUTestbench;

    reg clk;
    reg [15:0] A;
    reg [15:0] B;
    reg [4:0] functionSelect;
    reg [4:0] overwriteFlagsMask;
    reg [4:0] setFlagBits; // carry overflow zero pos neg
    wire [15:0] result;
    wire [4:0] currentFlags;    // carry overflow zero pos neg

    ALU uut(

        .clk(clk),
        .A(A),
        .B(B),
        .functionSelect(functionSelect),
        .overwriteFlagsMask(overwriteFlagsMask),
        .setFlagBits(setFlagBits),
        .result(result),
        .currentFlags(currentFlags)

    );

    initial begin

        A = 14; B = 28; functionSelect = 1; 
        #10 clk = 1; #10 clk = 0;

        #10 functionSelect = 17; overwriteFlagsMask = 5'b11111; setFlagBits = 5'b00100;
        #10 clk = 1; #10 clk = 0;

        overwriteFlagsMask = 5'b11111; setFlagBits = 5'b00000;
        #10 clk = 1; #10 clk = 0;

        A = 42; B = 28; functionSelect = 3; 
        #10 clk = 1; #10 clk = 0;

        A = 7; B = 89; functionSelect = 5;
        #10 clk = 1; #10 clk = 0;

        overwriteFlagsMask = 5'b11111; setFlagBits = 5'b10000;
        #10 clk = 1; #10 clk = 0;

        A = 42; B = 50; functionSelect = 3; 
        #10 clk = 1; #10 clk = 0;



    end

endmodule
