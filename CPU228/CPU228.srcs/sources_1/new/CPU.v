// Ethan Thummel | Amir Bahmandar | Fabiola Sore 4/13/23

`timescale 1ns / 1ps

module CPU(

    input boardclk,
    input btnC,
    input [15:0] sw,
    output [15:0] led

    );

    wire clk;    

    clkModule mainClk(boardclk, clk);

    wire programCounterCountUP;
    wire programCounterJump;
    wire [15:0] programCounterAddressIn;
    wire [15:0] programCounterAddressOut;
    assign programCounterAddressIn = bus;

    ProgramCounter PC(

        clk,
        programCounterCountUP,
        programCounterJump,
        programCounterAddressIn,
        programCounterAddressOut

    );

    wire loadInstruction;
    wire [15:0] instructionIn;
    wire [15:0] instructionOut;
    assign instructionIn = bus;

    InstructionRegister IR(

        clk,
        loadInstruction,
        instructionIn,
        instructionOut

    );

    wire loadMemoryAddress;
    wire [15:0] memoryAddressIn;
    wire [15:0] memoryAddressOut;
    assign memoryAddressIn = bus;

    MemoryAddressRegister MR(

        clk,
        loadMemoryAddress,
        memoryAddressIn,
        memoryAddressOut

    );

    wire StackCountUp;
    wire StackCountDown;
    wire [15:0] TopOfStack;

    StackPointer SP(

        clk,
        StackCountUp,
        StackCountDown,
        TopOfStack

    );

    wire RegFileWriteEnable; 
    wire [2:0] RegFileWriteAddress;
    wire [15:0] RegFileWriteData;
    wire [2:0] ReadAddressA;
    wire [2:0] ReadAddressB;
    wire [15:0] ReadDataA;
    wire [15:0] ReadDataB;
    assign RegFileWriteData = bus;

    RegisterFile RF(

        clk,
        RegFileWriteEnable,
        RegFileWriteAddress,
        RegFileWriteData,
        ReadAddressA,
        ReadAddressB,
        ReadDataA,
        ReadDataB,

    );

    wire signed [15:0] A;
    wire signed [15:0] B;
    wire [4:0] functionSelect;
    wire [4:0] overwriteFlagsMask;
    wire [4:0] setFlagBits;
    wire signed [15:0] result;
    wire [4:0] currentFlags;

    ArithmeticLogicUnit ALU(

        clk,
        A,
        B,
        functionSelect,
        overwriteFlagsMask,
        setFlagBits,
        result,
        currentFlags

    );

    wire RAMreadWrite;
    wire [15:0] RAMaddress;
    wire [15:0] RAMdataIn;
    wire [15:0] RAMdataOut;
    assign RAMdataIn = bus;

    Memory RAM(

        clk,
        RAMreadWrite,
        RAMaddress,
        RAMdataInm,
        RAMdataOut
        
    );

    ControlLogic CL(

        clk,
        instructionOut,
        currentFlags,
        programCounterCountUP,
        programCounterJump,
        loadInstruction,
        loadMemoryAddress,
        StackCountUp,
        StackCountDown,
        RegFileWriteEnable,
        RegFileWriteAddress,
        ReadAddressA,
        ReadAddressB,
        functionSelect,
        overwriteFlagsMask,
        setFlagBits,
        RAMreadWrite,
        busDrive

    );

    wire [2:0] busDrive;
    wire [15:0] bus;

    Bus BUS(

        busDrive,
        programCounterAddressOut,
        instructionOut,
        TopOfStack,
        result,
        RAMdataOut,
        16'h0000,
        16'h0000,
        16'h0000,
        bus

    );
    
endmodule
