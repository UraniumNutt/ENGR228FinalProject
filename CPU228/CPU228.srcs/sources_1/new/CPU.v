// Ethan Thummel | Amir Bahmandar | Fabiola Sore 4/13/23

`timescale 1ns / 1ps

module CPU(

    output [15:0] led,
    input boardclk,
    output [15:0] programCounterTest,
    output [15:0] instructionRegisterTest,
    output [15:0] stackPointerTest,
    output [15:0] memoryAddressRegisterTest,
    output [15:0] ATest,
    output [15:0] BTest,
    output [4:0] functionSelectTest,
    output [15:0] resultTest

    );

    assign programCounterTest = programCounter;
    assign instructionRegisterTest = instructionRegister;
    assign stackPointerTest = stackPointer;
    assign memoryAddressRegisterTest = memoryAddressRegister;
    assign ATest = A;
    assign BTest = B;
    assign functionSelectTest = functionSelect;
    assign resultTest = result;

    `include "opcodeParams.v"
    `include "addressingModeParams.v"
    `include "aluParams.v"

    wire clk;    
    assign clk = boardclk;
    //clkModule mainClk(boardclk, clk);

    
    localparam startVector = 16'h0000; // location in memory where execution starts. change as needed
    reg [15:0] programCounter;
    initial programCounter = startVector;

    localparam initialInstruction = 16'h0000;
    reg [15:0] instructionRegister;
    initial instructionRegister = initialInstruction;

    localparam topOfStack = 16'h8000;
    reg [15:0] stackPointer;
    initial stackPointer = topOfStack;

    localparam initialmemoryAddressRegister = 16'h0000;
    reg [15:0] memoryAddressRegister;
    initial memoryAddressRegister = initialmemoryAddressRegister;

    reg [15:0] ram [16383:0];

    
    
    reg [15:0] registerFile [7:0];
    assign led = registerFile[0];

    
    reg signed [15:0] A;
    reg signed [15:0] B;
    reg signed [15:0] constant;
    reg bSource;
    reg [4:0] functionSelect;
    reg [4:0] overwriteFlagsMask;
    reg [4:0] setFlagBits;
    wire signed [15:0] result;
    wire [4:0] currentFlags;

    ArithmeticLogicUnit alu(

        .clk(clk),
        .A(A),
        .B(B),
        .constant(constant),
        .bSource(bSource),
        .functionSelect(functionSelect),
        .overwriteFlagsMask(overwriteFlagsMask),
        .setFlagBits(setFlagBits),
        .result(result),
        .currentFlags(currentFlags)

    );

    wire [5:0] opcode = instructionRegister[15:10];
    wire [2:0] rx     = instructionRegister[9:7];
    wire [2:0] am     = instructionRegister[6:4];
    wire [2:0] ry     = instructionRegister[3:1];

    initial begin
        $readmemb("/home/uraniumnutt/Documents/VerilogProjects/ENGR228FinalProject/compiler/output.txt", ram, 0, 16383);
    end

  

    always @(posedge clk) begin

        case (opcode)

            NOP: begin
                programCounter = programCounter + 1;
            end

            LD: begin

                case (am)

                    direct: begin

                        memoryAddressRegister = ram[programCounter + 1];
                        registerFile[rx] = ram[memoryAddressRegister];
                        programCounter = programCounter + 2;
                        
                    end

                    immediate: begin

                        registerFile[rx] = ram[programCounter + 1];
                        programCounter = programCounter + 2;

                    end

                    indirect: begin

                        memoryAddressRegister = ram[programCounter + 1];
                        memoryAddressRegister = ram[memoryAddressRegister];
                        registerFile[rx] = ram[memoryAddressRegister];
                        programCounter = programCounter + 2;

                    end

                    directIndexed: begin

                        memoryAddressRegister = ram[programCounter + 1];
                        registerFile[rx] = ram[memoryAddressRegister + registerFile[ry]];
                        programCounter = programCounter + 2;

                    end

                    indirectIndexed: begin

                        memoryAddressRegister = ram[programCounter + 1];
                        memoryAddressRegister = ram[memoryAddressRegister];
                        registerFile[rx] = ram[memoryAddressRegister + registerFile[ry]];
                        programCounter = programCounter + 2;

                    end

                    register: begin

                        registerFile[rx] = registerFile[ry];
                        programCounter = programCounter + 1;

                    end

                    registerIndirect: begin

                        registerFile[rx] = ram[registerFile[ry]];
                        programCounter = programCounter + 1;

                    end

                endcase

            end

            ST: begin

                case (am)

                    direct: begin

                        memoryAddressRegister = ram[programCounter + 1];
                        ram[memoryAddressRegister] = registerFile[rx];
                        programCounter = programCounter + 2;

                    end

                    indirect: begin

                        memoryAddressRegister = ram[programCounter + 1];
                        memoryAddressRegister = ram[memoryAddressRegister];
                        ram[memoryAddressRegister] = registerFile[rx];
                        programCounter = programCounter + 2;

                    end

                    directIndexed: begin

                        memoryAddressRegister = ram[programCounter + 1];
                        ram[memoryAddressRegister + registerFile[ry]] = registerFile[rx];
                        programCounter = programCounter + 2;

                    end

                    indirectIndexed: begin
                        
                        memoryAddressRegister = ram[programCounter + 1];
                        memoryAddressRegister = ram[memoryAddressRegister];
                        ram[memoryAddressRegister + registerFile[ry]] = registerFile[rx];
                        programCounter = programCounter + 2;

                    end

                    register: begin

                        registerFile[ry] = registerFile[rx];
                        programCounter = programCounter + 1;

                    end

                    registerIndirect: begin

                        ram[registerFile[ry]] = registerFile[rx];
                        programCounter = programCounter + 1;

                    end

                endcase

            end

            default: begin

                programCounter = programCounter + 1;

            end

            REF: begin

                A = registerFile[rx];
                functionSelect = aluref;
                registerFile[rx] = result;
                bSource = 0;
                programCounter = programCounter + 1;

            end

            JMP: begin

                programCounter = ram[programCounter + 1];

            end

        endcase

        instructionRegister = ram[programCounter];

    end



    
endmodule
