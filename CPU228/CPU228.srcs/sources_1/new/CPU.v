// Ethan Thummel | Amir Bahmandar | Fabiola Sore 4/13/23

`timescale 1ns / 1ps

module CPU(

    output [15:0] led,
    input boardclk
    // output wire [15:0] instructionOutTest,  
    // output wire [4:0] currentFlagsTest,        
    // output wire programCounterCountUpTest,     
    // output wire programCounterJumpTest,        
    // output wire loadInstructionTest,           
    // output wire loadMemoryAddressTest,         
    // output wire StackCountUpTest,              
    // output wire StackCountDownTest,            
    // output wire RegFileWriteEnableTest,        
    // output wire [2:0] RegFileWriteAddressTest, 
    // output wire [2:0] ReadAddressATest,        
    // output wire [2:0] ReadAddressBTest,        
    // output wire [4:0] functionSelectTest,      
    // output wire [4:0] overwriteFlagsMaskTest,  
    // output wire [4:0] setFlagBitsTest,         
    // output wire RAMWriteReadTest,              
    // output wire bSourceTest,                  
    // output wire [2:0] busDriveTest,
    // output wire [15:0] busTest


    );

    // assign busTest                   = bus;
    // assign instructionOutTest        = instructionOut;
    // assign currentFlagsTest          = currentFlags;
    // assign programCounterCountUpTest = programCounterCountUp;
    // assign programCounterJumpTest    = programCounterJump;
    // assign loadInstructionTest       = loadInstruction;
    // assign loadMemoryAddressTest     = loadMemoryAddress;
    // assign StackCountUpTest          = StackCountUp;
    // assign StackCountDownTest        = StackCountDown;
    // assign RegFileWriteEnableTest    = RegFileWriteEnable;
    // assign RegFileWriteAddressTest   = RegFileWriteAddress;
    // assign ReadAddressATest          = ReadAddressA;
    // assign ReadAddressBTest          = ReadAddressB;
    // assign functionSelectTest        = functionSelect;
    // assign overwriteFlagsMaskTest    = overwriteFlagsMask;
    // assign setFlagBitsTest           = setFlagBits;
    // assign RAMWriteReadTest          = RAMWriteRead;
    // assign bSourceTest               = bSource;
    // assign busDriveTest              = busDrive;

    wire clk;    

    assign clk = boardclk;
    //clkModule mainClk(boardclk, clk);

    wire [2:0] busDrive;
    wire [15:0] bus;
    wire [15:0] TopOfStack;
    wire signed [15:0] result;
    wire [15:0] RAMdataOut;

    Bus BUS(

        busDrive,
        16'h0000,
        programCounterAddressOut,
        16'h0000,   
        TopOfStack,
        result,
        RAMdataOut,
        16'h0000,
        16'h0000,
        bus

    );


    wire programCounterCountUp;
    wire programCounterJump;
    wire [15:0] programCounterAddressIn;
    wire [15:0] programCounterAddressOut;
    assign programCounterAddressIn = bus;

    ProgramCounter PC(

        clk,
        programCounterCountUp,
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
    wire signed [15:0] ReadDataA;
    wire signed [15:0] ReadDataB;
    assign RegFileWriteData = bus;

    RegisterFile RF(

        led,
        clk,
        RegFileWriteEnable,
        RegFileWriteAddress,
        RegFileWriteData,
        ReadAddressA,
        ReadAddressB,
        ReadDataA,
        ReadDataB

    );

    wire [4:0] functionSelect;
    wire [4:0] overwriteFlagsMask;
    wire [4:0] setFlagBits;
    wire [4:0] currentFlags;
    wire bSource;


    ArithmeticLogicUnit ALU(

        clk,
        ReadDataA,
        ReadDataB,
        bus,
        bSource,
        functionSelect,
        overwriteFlagsMask,
        setFlagBits,
        result,
        currentFlags

    );

    wire RAMWriteRead;
    wire [15:0] RAMaddress;
    wire [15:0] RAMdataIn;
    assign RAMdataIn = bus;
    assign RAMaddress = memoryAddressOut;

    Memory RAM(

        clk,
        RAMWriteRead,
        RAMaddress,
        RAMdataIn,
        RAMdataOut
        
    );


    ControlLogic CL(

        clk,
        instructionOut,
        currentFlags,
        programCounterCountUp,
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
        RAMWriteRead,
        bSource,
        busDrive

    );


    
endmodule
