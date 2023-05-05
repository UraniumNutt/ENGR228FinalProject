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

    reg [15:0] ram [4095:0];

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
    
    assign programCounterTest = programCounter;
    assign instructionRegisterTest = instructionRegister;
    assign stackPointerTest = stackPointer;
    assign memoryAddressRegisterTest = memoryAddressRegister;
    assign ATest = A;
    assign BTest = B;
    assign functionSelectTest = functionSelect;
    assign resultTest = result;


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
        $readmemb("/home/uraniumnutt/Documents/VerilogProjects/ENGR228FinalProject/compiler/output.txt", ram);
    end

    reg [2:0] ucode;
    initial ucode = 0;
  

    always @(posedge clk) begin

        case (opcode)

            NOP: begin

                case (ucode)

                    0: programCounter = programCounter + 1;
                    1: ucode = 0;

                endcase

                ucode = ucode + 1;
                
            end

            LD: begin

                case (am)

                    direct: begin

                        case (ucode) 

                            0: memoryAddressRegister = ram[programCounter + 1];
                            1: registerFile[rx] = ram[memoryAddressRegister];
                            2: programCounter = programCounter + 2;
                            3: ucode = 0;

                        endcase

                        ucode = ucode + 1;

                    end

                    immediate: begin

                        case (ucode)

                            0: registerFile[rx] = ram[programCounter + 1];
                            1: programCounter = programCounter + 2;
                            2: ucode = 0;

                        endcase

                        ucode = ucode + 1;
                        
                    end

                    indirect: begin

                        case (ucode)

                            0: memoryAddressRegister = ram[programCounter + 1];
                            1: memoryAddressRegister = ram[memoryAddressRegister];
                            2: registerFile[rx] = ram[memoryAddressRegister];
                            3: programCounter = programCounter + 2;
                            4: ucode = 0;

                        endcase

                        ucode = ucode + 1;

                    end

                    directIndexed: begin

                        case (ucode)

                            0: memoryAddressRegister = ram[programCounter + 1];
                            1: registerFile[rx] = ram[memoryAddressRegister + registerFile[ry]];
                            2: programCounter = programCounter + 2;
                            3: ucode = 0;

                        endcase

                        ucode = ucode + 1;
                        
                    end

                    indirectIndexed: begin

                        case (ucode)

                            0: memoryAddressRegister = ram[programCounter + 1];
                            1: memoryAddressRegister = ram[memoryAddressRegister];
                            2: registerFile[rx] = ram[memoryAddressRegister + registerFile[ry]];
                            3: programCounter = programCounter + 2;
                            4: ucode = 0;

                        endcase

                        ucode = ucode + 1;
                        
                    end

                    register: begin

                        case (ucode)

                            0: registerFile[rx] = registerFile[ry];
                            1: programCounter = programCounter + 1;
                            2: ucode = 0;

                        endcase

                        ucode = ucode + 1;

                    end

                    registerIndirect: begin

                        case (ucode)

                            0: registerFile[rx] = ram[registerFile[ry]];
                            1: programCounter = programCounter + 1;
                            3: ucode = 0;

                        endcase

                        ucode = ucode + 1;

                    end

                endcase

            end

            ST: begin

                case (am)

                    direct: begin

                        case (ucode)

                            0: memoryAddressRegister = ram[programCounter + 1];
                            1: ram[memoryAddressRegister] = registerFile[rx];
                            2: programCounter = programCounter + 2;
                            3: ucode = 0;

                        endcase

                        ucode = ucode + 1;

                        

                    end

                    indirect: begin

                        case (ucode) 

                            0: memoryAddressRegister = ram[programCounter + 1];
                            1: memoryAddressRegister = ram[memoryAddressRegister];
                            2: ram[memoryAddressRegister] = registerFile[rx];
                            3: programCounter = programCounter + 2;
                            4: ucode = 0;

                        endcase

                        ucode = ucode + 1;

                        

                    end

                    directIndexed: begin

                        case (ucode)

                            0: memoryAddressRegister = ram[programCounter + 1];
                            1: ram[memoryAddressRegister + registerFile[ry]] = registerFile[rx];
                            2: programCounter = programCounter + 2;
                            3: ucode = 0;

                        endcase

                        ucode = ucode + 1;

                        

                    end

                    indirectIndexed: begin

                        case (ucode)

                            0: memoryAddressRegister = ram[programCounter + 1];
                            1: memoryAddressRegister = ram[memoryAddressRegister];
                            2: ram[memoryAddressRegister + registerFile[ry]] = registerFile[rx];
                            3: programCounter = programCounter + 2;
                            4: ucode = 0;

                        endcase

                        ucode = ucode + 1;
                        
                        

                    end

                    register: begin

                        case (ucode)

                            0: registerFile[ry] = registerFile[rx];
                            1: programCounter = programCounter + 1;
                            2: ucode = 0;

                        endcase

                        ucode = ucode + 1;

                        

                    end

                    registerIndirect: begin

                        case (ucode)

                            0: ram[registerFile[ry]] = registerFile[rx];
                            1: programCounter = programCounter + 1;
                            2: ucode = 0;

                        endcase

                        ucode = ucode + 1;

                    end

                endcase

            end

            default: begin

                case (ucode)

                    0: programCounter = programCounter + 1;
                    1: ucode = 0;

                endcase

                ucode = ucode + 1;

            end

            // REF: begin

            //     A = registerFile[rx];
            //     B = 0;
            //     constant = 0;
            //     functionSelect = aluref;
            //     registerFile[rx] = result;
            //     bSource = 0;
            //     programCounter = programCounter + 1;

            // end

            JMP: begin

                case (ucode)

                    0: programCounter = ram[programCounter + 1];
                    1: ucode = 0;

                endcase

                ucode = ucode + 1;

            end

        endcase

        instructionRegister = ram[programCounter];

        

    end



    
endmodule
