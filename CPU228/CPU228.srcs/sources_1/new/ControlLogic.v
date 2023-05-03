// Ethan Thummel | Amir Bahmandar | Fabiola Sore 4/27/23



`timescale 1ns / 1ps

module ControlLogic(

    input clk,
    input [15:0] instructionIn,
    input [4:0] currentFlags,
    output reg programCounterCountUp,
    output reg programCounterJump,
    output reg loadInstruction,
    output reg loadMemoryAddress,
    output reg StackCountUp,
    output reg StackCountDown,
    output reg RegFileWriteEnable,
    output reg [2:0] RegFileWriteAddress,
    output reg [2:0] ReadAddressA,
    output reg [2:0] ReadAddressB,
    output reg [4:0] functionSelect,
    output reg [4:0] overwriteFlagsMask,
    output reg [4:0] setFlagBits,
    output reg RAMWriteRead,
    output reg bSource,
    output reg [2:0] busDrive

    );

    `include "ControlLogicTasks.v"

    // these are the internal control bits
    reg pcup;
    reg pcjmp;
    reg irin;
    reg marin;
    reg spup;
    reg spdwn;
    reg rfw;
    reg [2:0] rfwa;
    reg [2:0] raa;
    reg [2:0] rab;
    reg [4:0] fs;
    reg [4:0] owfm;
    reg [4:0] sfb;
    reg ramw;
    reg bs;
    reg [2:0] bd;

    initial pcup  = 0;
    initial pcjmp = 0;
    initial irin  = 0;
    initial marin = 0;
    initial spup  = 0;
    initial spdwn = 0;
    initial rfw   = 0;
    initial rfwa  = 0;
    initial raa   = 0;
    initial rab   = 0;
    initial fs    = 0;
    initial owfm  = 0;
    initial sfb   = 0;
    initial ramw  = 0;
    initial bs    = 0;
    initial bd    = 0;

    

    // where in the instruction the information is stored
    wire [5:0] opcode = instructionIn[15:10];
    wire [2:0] rx     = instructionIn[9:7];
    wire [2:0] am     = instructionIn[6:4];
    wire [2:0] ry     = instructionIn[3:1];

    

    // micro instruction step counter
    reg [3:0] microInstructionCounter;
    initial microInstructionCounter = 0;
    reg microInstructionReset;
    initial microInstructionReset = 0;


    always @(posedge clk) begin

        if (microInstructionReset == 1) begin
            microInstructionCounter = 0;
        end

        else begin 
            microInstructionCounter = microInstructionCounter + 1;
        end

    end
    
    always @(negedge clk) begin
        
        case (opcode)

            nop: begin

                case (microInstructionCounter) 

                    0: begin
                        microInstructionReset = 0;
                        fetchnext0();
                        latchClear();
                    end
                    1: begin
                        fetchnext1();
                        latchClear();
                    end

                    2: begin 
                        fetchnext2();
                        latchClear();
                    end

                endcase

            end

            ld: begin

                case (am) 

                    direct: begin

                        case (microInstructionCounter)

                            0: begin
                                microInstructionReset = 0;
                                pcup = 1;
                                latchClear();

                            end
                            1: begin
                                bd = programCounterOut;
                                marin = 1;
                                latchClear();
                            end

                            2: begin
                                
                                bd = RAMOut;
                                marin = 1;
                                latchClear();
                            end

                            3: begin
                                bd = RAMOut;
                                rfw = 1;
                                rfwa = rx;
                                latchClear();
                            end

                            4: begin
                                fetchnext0();
                                latchClear();
                            end

                            5: begin
                                fetchnext1();
                                latchClear();
                            end

                            6: begin
                                fetchnext2();
                                latchClear();
                            end

                        endcase

                    end

                    immediate: begin

                        case (microInstructionCounter)

                            0: begin
                                microInstructionReset = 0;
                                pcup = 1;
                                latchClear();

                            end
                            1: begin
                                bd = programCounterOut;
                                marin = 1;
                                latchClear();
                            end
                                
                            2: begin
                                bd = RAMOut;
                                rfw = 1;
                                rfwa = rx;
                                latchClear();
                            end

                            3: begin
                                fetchnext0();
                                latchClear();
                            end

                            4: begin
                                fetchnext1();
                                latchClear();
                            end

                            5: begin
                                fetchnext2();
                                latchClear();
                            end

                        endcase

                    end

                    indirect: begin

                        case (microInstructionCounter)

                            0: begin
                                microInstructionReset = 0;
                                pcup = 1;
                                latchClear();
                            end
                            1: begin
                                bd = programCounterOut;
                                marin = 1;
                                latchClear();
                            end
                            2: begin
                                bd = RAMOut;
                                marin = 1;
                                latchClear();
                            end
                            3: begin
                                bd = RAMOut;
                                marin = 1;
                                latchClear();
                            end
                            4: begin
                                bd = RAMOut;
                                rfw = 1;
                                rfwa = rx;
                                latchClear();
                            end
                            5: begin
                                fetchnext0();
                                latchClear();
                            end
                            6: begin
                                fetchnext1();
                                latchClear();
                            end
                            7: begin
                                fetchnext2();
                                latchClear();
                            end

                        endcase

                    end

                    directIndexed: begin

                        case (microInstructionCounter)

                            0: begin
                                microInstructionReset = 0;
                                pcup = 1;
                                latchClear();
                            end

                            1: begin
                                bd = programCounterOut;
                                marin = 1;
                                latchClear();
                            end
                            2: begin

                                bd = RAMOut;
                                bs = 1;
                                raa = ry;
                                fs = ALUadd;
                                latchClear();
                            end
                            3: begin
                                bd = ALUOut;
                                marin = 1;
                                latchClear();
                            end
                            4: begin
                                bd = RAMOut;
                                rfw = 1;
                                rfwa = rx;
                                latchClear();
                            end
                            5: begin
                                fetchnext0();
                                latchClear();
                            end
                            6: begin
                                fetchnext1();
                                latchClear();
                            end
                            7: begin
                                fetchnext2();
                                latchClear();
                            end

                        endcase

                    end

                    indirectIndexed: begin
                        
                        case (microInstructionCounter) 

                            0: begin
                                microInstructionReset = 0;
                                pcup = 1;
                                latchClear();
                            end
                            1: begin
                                bd = programCounterOut;
                                marin = 1;
                                latchClear();
                            end
                            2: begin
                                bd = RAMOut;
                                marin = 1;
                                latchClear();
                            end
                            3: begin
                                bd = RAMOut;
                                bs = 1;
                                raa = ry;
                                fs = ALUadd;
                                latchClear();
                            end
                            4: begin
                                bd = ALUOut;
                                marin = 1;
                                latchClear();
                            end
                            5: begin
                                bd = RAMOut;
                                rfw = 1;
                                rfwa = rx;
                                latchClear();
                            end
                            6: begin
                                fetchnext0();
                                latchClear();
                            end
                            7: begin
                                fetchnext1();
                                latchClear();
                            end
                            8: begin
                                fetchnext2();
                                latchClear();
                            end

                        endcase

                    end

                    register: begin
                        
                        case (microInstructionCounter) 

                            0: begin
                                microInstructionReset = 0;
                                fs = ALUref;
                                raa = ry;
                                latchClear();

                            end
                            1: begin
                                bd = ALUOut;
                                rfw = 1;
                                rfwa = rx;
                                latchClear();
                            end
                            2: begin
                                fetchnext0();
                                latchClear();
                            end
                            3: begin
                                fetchnext1();
                                latchClear();
                            end
                            4: begin
                                fetchnext2();
                                latchClear();
                            end
                        
                        endcase

                    end

                    registerIndirect: begin

                        case (microInstructionCounter) 


                            0: begin
                                microInstructionReset = 0;
                                fs = ALUref;
                                raa = ry;
                                latchClear();
                            end
                            1: begin
                                bd = ALUOut;
                                marin = 1;
                                latchClear();
                            end
                            2: begin
                                bd = RAMOut;
                                rfw = 1;
                                rfwa = rx;
                                latchClear();
                            end
                            3: begin
                                fetchnext0();
                                latchClear();
                            end
                            4: begin
                                fetchnext1();
                                latchClear();
                            end
                            5: begin
                                fetchnext2();
                                latchClear();
                            end

                        endcase

                    end

                    default: begin

                        case (microInstructionCounter)

                            0: begin
                                microInstructionReset = 0;
                                fetchnext0();
                                latchClear();
                            end
                            1: begin
                                fetchnext1();
                                latchClear();
                            end
                            2: begin
                                fetchnext2();
                                latchClear();
                            end

                        endcase

                    end

                endcase

            end

            st: begin

                case (am) 

                    direct: begin

                        case (microInstructionCounter)

                            0: begin
                                microInstructionReset = 0;
                                pcup = 1;
                                latchClear();

                            end
                            1: begin
                                bd = programCounterOut;
                                marin = 1;
                                latchClear();
                            end

                            2: begin
                                bd = RAMOut;
                                marin = 1;
                                latchClear();
                            end

                            3: begin
                                fs = ALUref;
                                raa = rx;
                                latchClear();
                            end
                            
                            4: begin

                                bd = ALUOut;
                                ramw = 1;
                                latchClear();
                            end
                            
                            5: begin
                                fetchnext0();
                                latchClear();
                            end
                            6: begin
                                fetchnext1();
                                latchClear();
                            end
                            7: begin
                                fetchnext2();
                                latchClear();
                            end


                        endcase

                    end


                    indirect: begin

                        case (microInstructionCounter)

                            0: begin
                                microInstructionReset = 0;
                                pcup = 1;
                                latchClear();
                            end
                            1: begin
                                bd = programCounterOut;
                                marin = 1;
                                latchClear();
                            end
                            2: begin
                                bd = RAMOut;
                                marin = 1;
                                latchClear();
                            end
                            3: begin
                                bd = RAMOut;
                                marin = 1;
                                latchClear();
                            end

                            4: begin

                                fs = ALUref;
                                raa = rx;
                                latchClear();
                            end
                            5: begin

                                bd = ALUOut;
                                ramw = 1;
                                latchClear();
                            end
                            6: begin
                                fetchnext0();
                                latchClear();
                            end
                            7: begin
                                fetchnext1();
                                latchClear();
                            end
                            8: begin
                                fetchnext2();
                                latchClear();
                            end

                        endcase


                    end

                    directIndexed: begin

                        case (microInstructionCounter)

                            0: begin
                                microInstructionReset = 0;
                                pcup = 1;
                                latchClear();
                            end

                            1: begin
                                bd = programCounterOut;
                                marin = 1;
                                latchClear();
                            end
                            2: begin

                                bd = RAMOut;
                                bs = 1;
                                raa = ry;
                                fs = ALUadd;
                                latchClear();
                            end
                            3: begin
                                bd = ALUOut;
                                marin = 1;
                                latchClear();
                            end
                            4: begin

                                fs = ALUref;
                                raa = rx;
                                latchClear();
                            end
                            5: begin

                                bd = ALUOut;
                                ramw = 1;
                                latchClear();
                            end
                            6: begin
                                fetchnext0();
                                latchClear();
                            end
                            7: begin
                                fetchnext1();
                                latchClear();
                            end
                            8: begin
                                fetchnext2();
                                latchClear();
                            end

                        endcase

                    end

                    indirectIndexed: begin

                        case (microInstructionCounter)

                            0: begin
                                microInstructionReset = 0;
                                pcup = 1;
                                latchClear();
                            end
                            1: begin
                                bd = programCounterOut;
                                marin = 1;
                                latchClear();
                            end
                            2: begin
                                bd = RAMOut;
                                marin = 1;
                                latchClear();
                            end
                            3: begin
                                bd = RAMOut;
                                bs = 1;
                                raa = ry;
                                fs = ALUadd;
                                latchClear();
                            end
                            4: begin
                                bd = ALUOut;
                                marin = 1;
                                latchClear();
                            end
                            5: begin

                                fs = ALUref;
                                raa = rx;
                                latchClear();
                            end
                            6: begin

                                bd = ALUOut;
                                ramw = 1;
                                latchClear();
                            end
                            7: begin
                                fetchnext0();
                                latchClear();
                            end
                            8: begin
                                fetchnext1();
                                latchClear();
                            end
                            9: begin
                                fetchnext2();
                                latchClear();
                            end

                        endcase


                    end




                    register: begin

                        case (microInstructionCounter)

                            0: begin
                                microInstructionReset = 0;

                                latchClear();
                            end
                            1: begin
                                fs = ALUref;
                                raa = rx;
                                latchClear();
                            end
                            2: begin
                                bd = ALUOut;
                                rfw = 1;
                                rfwa = ry;
                                latchClear();
                            end
                            3: begin
                                fetchnext0();
                                latchClear();
                            end
                            4: begin
                                fetchnext1();
                                latchClear();
                            end
                            5: begin
                                fetchnext2();
                                latchClear();
                            end


                        endcase

                    end

                    registerIndirect: begin

                        case (microInstructionCounter)

                            0: begin
                                microInstructionReset = 0;

                                latchClear();
                            end
                            1: begin
                                fs = ALUref;
                                raa = ry;
                                latchClear();
                            end
                            2: begin
                                bd = ALUOut;
                                marin = 1;
                                latchClear();
                            end
                            3: begin
                                fs = ALUref;
                                raa = rx;
                                latchClear();
                            end
                            4: begin
                                bd = ALUOut;
                                ramw = 1;
                                latchClear();
                            end
                            5: begin
                                fetchnext0();
                                latchClear();
                            end
                            6: begin
                                fetchnext1();
                                latchClear();
                            end
                            7: begin
                                fetchnext2();
                                latchClear();
                            end

                        endcase

                    end

                endcase


            end

            ref: begin

                aluonearg(ALUref);

            end

            add: begin

                case (am)

                    direct: begin

                        case (microInstructionCounter)

                            0: begin
                                microInstructionReset = 0;
                                pcup = 1;
                                latchClear();

                            end
                            1: begin
                                bd = programCounterOut;
                                marin = 1;
                                latchClear();
                            end
                            2: begin
                                bd = RAMOut;
                                marin = 1;
                                latchClear();
                            end
                            3: begin
                               bd = RAMOut;
                               bs = 1;
                               fs = ALUadd;
                               raa = rx;
                               latchClear();
                            end
                            4: begin
                                bd = ALUOut;
                                rfw = 1;
                                rfwa = rx;
                                latchClear();
                            end
                            5: begin
                                fetchnext0();
                                latchClear();
                            end
                            6: begin
                                fetchnext1();
                                latchClear();
                            end
                            7: begin
                                fetchnext2();
                                latchClear();
                            end

                        endcase

                    end

                    immediate: begin

                        case (microInstructionCounter)

                            0: begin

                                microInstructionReset = 0;
                                pcup = 1;
                                latchClear();
                                

                            end

                            1: begin

                                bd = programCounterOut;
                                marin = 1;
                                latchClear(); 
                                
                            end

                            2: begin

                                bd = RAMOut;
                                bs = 1;
                                fs = ALUadd;
                                raa = rx;
                                latchClear();

                            end

                            3: begin

                                bd = ALUOut;
                                rfw = 1;
                                rfwa = rx;
                                latchClear();

                            end

                            4: begin

                                fetchnext0();
                                latchClear();

                            end

                            5: begin 
                                fetchnext1();
                                latchClear();
                            end

                            6: begin
                                fetchnext2();
                                latchClear();
                            end

                        endcase

                    end

                    indirect: begin

                        case (microInstructionCounter)

                            0: begin
                                microInstructionReset = 0;
                                pcup = 1;
                                latchClear();
                            end
                            1: begin
                                bd = programCounterOut;
                                marin = 1;
                                latchClear();
                            end
                            2: begin
                                bd = RAMOut;
                                marin = 1;
                                latchClear();
                            end
                            3: begin
                                bd = RAMOut;
                                marin = 1;
                                latchClear();
                            end
                            4: begin
                                bd = RAMOut;
                                fs = ALUadd;
                                bs = 1;
                                raa = rx;
                                latchClear();
                            end
                            5: begin
                                bd = ALUOut;
                                rfw = 1;
                                rfwa = rx;
                                latchClear();
                            end
                            6: begin

                                fetchnext0();
                                latchClear();

                            end

                            7: begin 
                                fetchnext1();
                                latchClear();
                            end

                            8: begin
                                fetchnext2();
                                latchClear();
                            end

                        endcase

                    end

                    directIndexed: begin

                        case (microInstructionCounter)

                            0: begin
                                microInstructionReset = 0;
                                pcup = 1;
                                latchClear();
                            end

                            1: begin
                                bd = programCounterOut;
                                marin = 1;
                                latchClear();
                            end
                            2: begin

                                bd = RAMOut;
                                bs = 1;
                                raa = ry;
                                fs = ALUadd;
                                latchClear();
                            end
                            3: begin
                                bd = ALUOut;
                                marin = 1;
                                latchClear();
                            end
                            4: begin
                                bd = RAMOut;
                                fs = ALUadd;
                                bs = 1;
                                raa = rx;
                                latchClear();
                            end
                            5: begin
                                bd = ALUOut;
                                rfw = 1;
                                rfwa = rx;
                                latchClear();
                            end
                            6: begin

                                fetchnext0();
                                latchClear();

                            end

                            7: begin 
                                fetchnext1();
                                latchClear();
                            end

                            8: begin
                                fetchnext2();
                                latchClear();
                            end



                        endcase

                    end

                    indirectIndexed: begin

                        case (microInstructionCounter)

                            
                            0: begin
                                microInstructionReset = 0;
                                pcup = 1;
                                latchClear();
                            end

                            1: begin
                                bd = programCounterOut;
                                marin = 1;
                                latchClear();
                            end
                            2: begin
                                bd = RAMOut;
                                marin = 1;
                                latchClear();
                            end
                            3: begin

                                bd = RAMOut;
                                bs = 1;
                                raa = ry;
                                fs = ALUadd;
                                latchClear();
                            end
                            4: begin
                                bd = ALUOut;
                                marin = 1;
                                latchClear();
                            end
                            5: begin
                                bd = RAMOut;
                                fs = ALUadd;
                                bs = 1;
                                raa = rx;
                                latchClear();
                            end
                            6: begin
                                bd = ALUOut;
                                rfw = 1;
                                rfwa = rx;
                                latchClear();
                            end
                            7: begin

                                fetchnext0();
                                latchClear();

                            end

                            8: begin 
                                fetchnext1();
                                latchClear();
                            end

                            9: begin
                                fetchnext2();
                                latchClear();
                            end

                        endcase




                    end

                    register: begin

                        case (microInstructionCounter)

                            0: begin
                                microInstructionReset = 0;
                                latchClear();
                            end
                            1: begin
                                fs = ALUadd;
                                raa = rx;
                                rab = ry;
                                latchClear();
                            end
                            2: begin
                                bd = ALUOut;
                                rfw = 1;
                                rfwa = rx;
                                latchClear();
                            end
                            3: begin
                                fetchnext0();
                                latchClear();
                            end
                            4: begin
                                fetchnext1();
                                latchClear();
                            end
                            5: begin
                                fetchnext2();
                                latchClear();
                            end

                        endcase

                    end

                    registerIndirect: begin

                        case (microInstructionCounter)

                            0: begin
                                microInstructionReset = 0;
                                fs = ALUref;
                                raa = ry;
                                latchClear();
                            end
                            1: begin
                                bd = ALUOut;
                                marin = 1;
                                latchClear();
                            end
                            2: begin
                                bd = RAMOut;
                                bs = 1;
                                fs = ALUadd;
                                raa = rx;
                                latchClear();
                            end
                            4: begin
                                bd = ALUOut;
                                rfw = 1;
                                rfwa = rx;
                                latchClear();
                            end
                            5: begin
                                fetchnext0();
                                latchClear();
                            end
                            6: begin
                                fetchnext1();
                                latchClear();
                            end
                            7: begin
                                fetchnext2();
                                latchClear();
                            end

                        endcase

                    end


                endcase

            end

            jmp: begin

                case (am)

                    direct: begin

                    case (microInstructionCounter)

                        0: begin
                            microInstructionReset = 0;
                            pcup = 1;
                            latchClear();

                        end

                        1: begin

                            bd = programCounterOut;
                            marin = 1;
                            latchClear();

                        end

                        2: begin

                            bd = RAMOut;
                            pcjmp = 1;
                            latchClear();

                        end

                        3: begin
                            fetchnext1(); // already set pc
                            latchClear();
                        end

                        4: begin
                            fetchnext2(); 
                            latchClear();
                        end

                    endcase

                    end

                endcase

            end

            default: begin

                case (microInstructionCounter) 

                    0: begin
                        microInstructionReset = 0;
                        fetchnext0();
                        latchClear();
                    end
                    1: begin
                        fetchnext1();
                        latchClear();
                    end

                    3: begin
                        fetchnext2();
                        latchClear();
                    end

                endcase

            end

        endcase

    end


endmodule
