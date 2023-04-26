// Ethan Thummel | Amir Bahmandar | Fabiola Sore 4/13/23

`timescale 1ns / 1ps

module CPU(

    input boardclk,
    input btnC,
    input [15:0] sw,
    output [15:0] led

    );

    clkModule mainClk(boardclk, clk);

    wire programCounterCountUP;
    wire programCounterJump;
    wire [15:0] programCounterAddressIn;
    wire [15:0] programCounterAddressOut;

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

    InstructionRegister IR(

        clk,
        loadInstruction,
        instructionIn,
        instructionOut

    );

    wire loadMemoryAddress;
    wire [15:0] memoryAddressIn;
    wire [15:0] memoryAddressOut;

    MemoryAddressRegister MR(

        clk,
        loadMemoryAddress,
        memoryAddressIn,
        memoryAddressOut

    );

    wire CountUp;
    wire CountDown;
    wire [15:0] TopOfStack;

    StackPointer SP(

        clk,
        CountUp,
        CountDown,
        TopOfStack

    );

    wire WriteEnable; 
    wire [15:0] WriteAddress;
    wire [15:0] WriteData;
    wire [15:0] ReadAddressA;
    wire [15:0] ReadAddressB;
    wire [15:0] ReadAddressIndex;
    wire [15:0] ReadDataA;
    wire [15:0] ReadDataB;
    wire [15:0] ReadDataIndex;

    RegisterFile RF(

        clk,
        WriteEnable,
        WriteAddress,
        WriteData,
        ReadAddressA,
        ReadAddressB,
        ReadAddressIndex,
        ReadDataA,
        ReadDataB,
        ReadDataIndex

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

    Memory RAM(

        clk,
        RAMreadWrite,
        RAMaddress,
        RAMdataInm,
        RAMdataOut
        
    );
    
endmodule
