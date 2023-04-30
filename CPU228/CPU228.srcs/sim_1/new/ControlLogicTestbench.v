// Ethan Thummel | Amir Bahmandar | Fabiola Sore 4/27/23

`timescale 1ns / 1ps

module ControlLogicTestbench;

    reg clk;
    reg [15:0] instructionIn;
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
    wire RAMWriteRead;
    wire bSource;
    wire [2:0] busDrive;

    ControlLogic uut(

        .clk(clk),
        .instructionIn(instructionIn),
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
        .RAMWriteRead(RAMWriteRead),
        .bSource(bSource),
        .busDrive(busDrive)

    );

    initial begin

        currentFlags = 0; instructionIn = 16'b00001000_01010010; clk = 0;
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
