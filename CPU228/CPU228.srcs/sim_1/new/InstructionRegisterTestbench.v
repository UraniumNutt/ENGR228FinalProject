// Ethan Thummel | Amir Bahmandar | Fabiola Sore 4/17/23

`timescale 1ns / 1ps

module InstructionRegisterTestbench;

    reg clk;
    reg [15:0] instructionIn;
    wire [15:0] instructionOut;

    InstructionRegister uut(

        .clk(clk),
        .instructionIn(instructionIn),
        .instructionOut(instructionOut)

    );

    initial begin

        instructionIn = 16'h7e00;
        #10 clk = 1; #10 clk = 0;

    end

endmodule
