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
    `include "aluInstructionParams.v"

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

    reg [4:0] flags;
    
    assign programCounterTest = programCounter;
    assign instructionRegisterTest = instructionRegister;
    assign stackPointerTest = stackPointer;
    assign memoryAddressRegisterTest = memoryAddressRegister;
    assign ATest = A;
    assign BTest = B;
    assign functionSelectTest = functionSelect;
    assign resultTest = result;

    initial A = 0;
    initial B = 0;
    initial functionSelect = 0;
    initial constant = 0;
    initial bSource = 0;
    initial setFlagBits = 0;
    initial overwriteFlagsMask = 0;



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

                    0: begin
                        programCounter = programCounter + 1;
                        ucode = ucode + 1;
                    end
                    1: begin
                        instructionRegister = ram[programCounter];
                        ucode = 0;
                    end


                endcase

                
                
            end

            LD: begin

                case (am)

                    direct: begin

                        case (ucode) 

                            0: begin
                                memoryAddressRegister = ram[programCounter + 1];
                                ucode = ucode + 1;
                            end
                            1: begin
                                registerFile[rx] = ram[memoryAddressRegister];
                                ucode = ucode + 1;
                            end
                            2: begin
                                programCounter = programCounter + 2;
                                ucode = ucode + 1;
                            end
                            3: begin
                                instructionRegister = ram[programCounter];
                                ucode = 0;
                            end

                        endcase

                        

                    end

                    immediate: begin

                        case (ucode)

                            0: begin
                                registerFile[rx] = ram[programCounter + 1];
                                ucode = ucode + 1;
                            end
                            1: begin
                                programCounter = programCounter + 2;
                                ucode = ucode + 1;
                            end
                            2: begin
                                instructionRegister = ram[programCounter];
                                ucode = 0;
                            end
                            

                        endcase

                        
                        
                    end

                    indirect: begin

                        case (ucode)

                            0: begin
                                memoryAddressRegister = ram[programCounter + 1];
                                ucode = ucode + 1;
                            end
                            1: begin
                                memoryAddressRegister = ram[memoryAddressRegister];
                                ucode = ucode + 1;
                            end
                            2: begin
                                registerFile[rx] = ram[memoryAddressRegister];
                                ucode = ucode + 1;
                            end
                            3: begin
                                programCounter = programCounter + 2;
                                ucode = ucode + 1;
                            end
                            4: begin
                                instructionRegister = ram[programCounter];
                                ucode = 0;
                            end
                            

                        endcase

                        

                    end

                    directIndexed: begin

                        case (ucode)

                            0: begin
                                memoryAddressRegister = ram[programCounter + 1];
                                ucode = ucode + 1;
                            end
                            1: begin
                                registerFile[rx] = ram[memoryAddressRegister + registerFile[ry]];
                                ucode = ucode + 1;
                            end
                            2: begin
                                programCounter = programCounter + 2;
                                ucode = ucode + 1;
                            end
                            3: begin
                                instructionRegister = ram[programCounter];
                                ucode = 0;
                            end
                            

                        endcase

                        
                        
                    end

                    indirectIndexed: begin

                        case (ucode)

                            0: begin
                                memoryAddressRegister = ram[programCounter + 1];
                                ucode = ucode + 1;
                            end
                            1: begin
                                memoryAddressRegister = ram[memoryAddressRegister];
                                ucode = ucode + 1;
                            end
                            2: begin
                                registerFile[rx] = ram[memoryAddressRegister + registerFile[ry]];
                                ucode = ucode + 1;
                            end
                            3: begin
                                programCounter = programCounter + 2;
                                ucode = ucode + 1;
                            end
                            4: begin
                                instructionRegister = ram[programCounter];
                                ucode = 0;
                            end
                            

                        endcase

                        
                        
                    end

                    register: begin

                        case (ucode)

                            0: begin
                                registerFile[rx] = registerFile[ry];
                                ucode = ucode + 1;
                            end
                            1: begin
                                programCounter = programCounter + 1;
                                ucode = ucode + 1;
                            end
                            2: begin
                                instructionRegister = ram[programCounter];
                                ucode = 0;
                            end
                            

                        endcase

                        

                    end

                    registerIndirect: begin

                        case (ucode)

                            0: begin
                                registerFile[rx] = ram[registerFile[ry]];
                                ucode = ucode + 1;
                            end
                            1: begin
                                programCounter = programCounter + 1;
                                ucode = ucode + 1;
                            end
                            2: begin
                                instructionRegister = ram[programCounter];
                                ucode = 0;
                            end
                            

                        endcase

                        

                    end

                endcase

            end

            ST: begin

                case (am)

                    direct: begin

                        case (ucode)

                            0: begin
                                memoryAddressRegister = ram[programCounter + 1];
                                ucode = ucode + 1;
                            end
                            1: begin
                                ram[memoryAddressRegister] = registerFile[rx];
                                ucode = ucode + 1;
                            end
                            2: begin
                                programCounter = programCounter + 2;
                                ucode = ucode + 1;
                            end
                            3: begin
                                instructionRegister = ram[programCounter];
                                ucode = 0;
                            end
                            

                        endcase

                        

                        

                    end

                    indirect: begin

                        case (ucode) 

                            0: begin
                                memoryAddressRegister = ram[programCounter + 1];
                                ucode = ucode + 1;
                            end
                            1: begin
                                memoryAddressRegister = ram[memoryAddressRegister];
                                ucode = ucode + 1;
                            end
                            2: begin
                                ram[memoryAddressRegister] = registerFile[rx];
                                ucode = ucode + 1;
                            end
                            3: begin
                                programCounter = programCounter + 2;
                                ucode = ucode + 1;
                            end
                            4: begin
                                instructionRegister = ram[programCounter];
                                ucode = 0;
                            end

                            

                        endcase

                        

                        

                    end

                    directIndexed: begin

                        case (ucode)

                            0: begin
                                memoryAddressRegister = ram[programCounter + 1];
                                ucode = ucode + 1;
                            end
                            1: begin
                                ram[memoryAddressRegister + registerFile[ry]] = registerFile[rx];
                                ucode = ucode + 1;
                            end
                            2: begin
                                programCounter = programCounter + 2;
                                ucode = ucode + 1;
                            end
                            3: begin
                                instructionRegister = ram[programCounter];
                                ucode = 0;
                            end
                            

                        endcase

                        

                        

                    end

                    indirectIndexed: begin

                        case (ucode)

                            0: begin
                                memoryAddressRegister = ram[programCounter + 1];
                                ucode = ucode + 1;
                            end
                            1: begin
                                memoryAddressRegister = ram[memoryAddressRegister];
                                ucode = ucode + 1;
                            end
                            2: begin
                                ram[memoryAddressRegister + registerFile[ry]] = registerFile[rx];
                                ucode = ucode + 1;
                            end
                            3: begin
                                programCounter = programCounter + 2;
                                ucode = ucode + 1;
                            end
                            4: begin
                                instructionRegister = ram[programCounter];
                                ucode = 0;
                            end
                            

                        endcase

                        
                        
                        

                    end

                    register: begin

                        case (ucode)

                            0: begin
                                registerFile[ry] = registerFile[rx];
                                ucode = ucode + 1;
                            end
                            1: begin
                                programCounter = programCounter + 1;
                                ucode = ucode + 1;
                            end
                            2: begin
                                instructionRegister = ram[programCounter];
                                ucode = 0;
                            end
                            
                            

                        endcase

                        

                        

                    end

                    registerIndirect: begin

                        case (ucode)

                            0: begin
                                ram[registerFile[ry]] = registerFile[rx];
                                ucode = ucode + 1;
                            end
                            1: begin
                                programCounter = programCounter + 1;
                                ucode = ucode + 1;
                            end
                            2: begin
                                instructionRegister = ram[programCounter];
                                ucode = 0;
                            end
                            

                        endcase

                        

                    end

                endcase

            end

            default: begin

                case (ucode)

                    0: begin
                        programCounter = programCounter + 1;
                        ucode = ucode + 1;
                    end
                    1: begin
                        instructionRegister = ram[programCounter];
                        ucode = 0;
                    end
                    
                endcase

                

            end

            REF: begin

                
                `aluOneArg(aluref)


            end

            INC: begin

                `aluOneArg(aluinc)

            end

            JMP: begin

                case (ucode)

                    0: begin
                        programCounter = ram[programCounter + 1];
                        ucode = ucode + 1;
                    end
                    1: begin
                        instructionRegister = ram[programCounter];
                        ucode = 0;
                    end
                    
                endcase

                

            end

        endcase


        

    end



    
endmodule
