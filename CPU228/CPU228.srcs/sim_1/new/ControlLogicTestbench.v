// Ethan Thummel | Amir Bahmandar | Fabiola Sore 4/27/23

`timescale 1ns / 1ps

module ControlLogicTestbench;

    reg clk;
    reg [15:0] instructionOut;
    reg [4:0] currentFlags;
    wire programCounterCountUp;
    wire programCounterJump;
    wire loadInstruction;
    wire loadMemoryAddress;
    wire StackCountUp;
    wire StackCountDown;
    wire RegFileWriteEnable;
    wire [2:0] RegFileWriteAddress;
    wire [2:0] ReadAddressA;
    wire [2:0] ReadAddressB;
    wire [4:0] functionSelect;
    wire [4:0] overwriteFlagsMask;
    wire [4:0] setFlagBits;
    wire RAMreadWrite;
    wire [2:0] busDrive;

    ControlLogic uut(

        .clk(clk),
        .instructionOut(instructionOut),
        .currentFlags(currentFlags),
        .programCounterCountUp(programCounterCountUp),
        .programCounterJump(programCounterJump),
        .loadInstruction(loadInstruction),
        .loadMemoryAddress(loadMemoryAddress),
        .StackCountUp(StackCountUp),
        .StackCountDown(StackCountDown),
        .RegFileWriteEnable(RegFileWriteEnable),
        .RegFileWriteAddress(RegFileWriteAddress),
        .ReadAddressA(ReadAddressA),
        .ReadAddressB(ReadAddressB),
        .functionSelect(functionSelect),
        .overwriteFlagsMask(overwriteFlagsMask),
        .setFlagBits(setFlagBits),
        .RAMreadWrite(RAMreadWrite),
        .busDrive(busDrive)

    );

    initial begin

        currentFlags = 0; instructionOut = 0;
        #10 clk = 1; #10 clk = 0;
        #10 clk = 1; #10 clk = 0;
        #10 clk = 1; #10 clk = 0;
        #10 clk = 1; #10 clk = 0;
        #10 clk = 1; #10 clk = 0;
        #10 clk = 1; #10 clk = 0;
        #10 clk = 1; #10 clk = 0;
        #10 clk = 1; #10 clk = 0;
        #10 clk = 1; #10 clk = 0;
        #10 clk = 1; #10 clk = 0;
        #10 clk = 1; #10 clk = 0;
        #10 clk = 1; #10 clk = 0;

    end


endmodule
