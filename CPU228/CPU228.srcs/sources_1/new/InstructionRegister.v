// Ethan Thummel | Amir Bahmandar | Fabiola Sore 4/17/23

`timescale 1ns / 1ps

module InstructionRegister(

    input clk,
    input [15:0] instructionIn,
    output [15:0] instructionOut

    );

    localparam initialInstruction = 16'h0000; // what the instruction register starts out with. change to a desirable first instruction if necessary

    reg [15:0] currentInstruction;
    initial currentInstruction = initialInstruction;

    assign instructionOut = currentInstruction;

    always @(posedge clk) begin

        currentInstruction = instructionIn;

    end
endmodule
