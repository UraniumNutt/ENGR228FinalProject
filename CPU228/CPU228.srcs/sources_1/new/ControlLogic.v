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

    // macro for setting external control bits to internal control bit, then clearing the internal control bits for the next cycle
    `define latchClear() \
        programCounterCountUp = pcup; \
        programCounterJump = pcjmp; \
        loadInstruction = irin; \
        loadMemoryAddress = marin; \
        StackCountUp = spup; \
        StackCountDown = spdwn; \
        RegFileWriteEnable = rfw; \
        RegFileWriteAddress = rfwa; \
        ReadAddressA = raa; \
        ReadAddressB = rab; \
        functionSelect = fs; \
        overwriteFlagsMask = owfm; \
        setFlagBits = sfb; \
        RAMWriteRead = ramw; \
        bSource = bs; \
        busDrive = bd; \
        pcup = 0; \
        pcjmp = 0; \
        irin = 0; \
        marin = 0; \
        spup = 0; \
        spdwn = 0; \
        rfw = 0; \
        rfwa = 0; \
        raa = 0; \
        rab = 0; \
        fs = 0; \
        owfm = 0; \
        sfb = 0; \
        ramw = 0; \
        bs = 0; \
        bd = 0;

    `define fetchnext0() \
        pcup  = 1; \
        pcjmp = 0; \
        irin  = 0; \
        marin = 0; \
        spup  = 0; \
        spdwn = 0; \
        rfw   = 0; \
        rfwa  = 0; \
        raa   = 0; \
        rab   = 0; \
        fs    = 0; \
        owfm  = 0; \
        sfb   = 0; \
        ramw  = 0; \
        bs    = 0; \
        bd    = 0;

    `define fetchnext1() \
        pcup  = 0; \
        pcjmp = 0; \
        irin  = 0; \
        marin = 1; \
        spup  = 0; \
        spdwn = 0; \
        rfw   = 0; \
        rfwa  = 0; \
        raa   = 0; \
        rab   = 0; \
        fs    = 0; \
        owfm  = 0; \
        sfb   = 0; \
        ramw  = 0; \
        bs    = 0; \
        bd    = programCounterOut;
        

    `define fetchnext2() \
        pcup  = 0; \
        pcjmp = 0; \
        irin  = 1; \
        marin = 0; \
        spup  = 0; \
        spdwn = 0; \
        rfw   = 0; \
        rfwa  = 0; \
        raa   = 0; \
        rab   = 0; \
        fs    = 0; \
        owfm  = 0; \
        sfb   = 0; \
        ramw  = 0; \
        bs    = 0; \
        bd    = RAMOut; \
        microInstructionReset = 1;

    // where in the instruction the information is stored
    wire [5:0] opcode = instructionIn[15:10];
    wire [2:0] rx     = instructionIn[9:7];
    wire [2:0] am     = instructionIn[6:4];
    wire [2:0] ry     = instructionIn[3:1];

    // opcodes and their values
    localparam nop  = 6'b000000;
    localparam ld   = 6'b000001;
    localparam st   = 6'b000010;
    localparam ref  = 6'b000011;
    localparam add  = 6'b000100;
    localparam adwc = 6'b000101;
    localparam sub  = 6'b000110;
    localparam sbwb = 6'b000111;
    localparam mul  = 6'b001000;
    localparam inc  = 6'b001001;
    localparam dec  = 6'b001010;
    localparam chs  = 6'b001011;
    localparam AND  = 6'b001100;
    localparam OR   = 6'b001101;
    localparam NOT  = 6'b001110;
    localparam XOR  = 6'b001111;
    localparam sl   = 6'b010000;
    localparam sr   = 6'b010001;
    localparam cmp  = 6'b010010;
    localparam bit  = 6'b010011;
    localparam zc   = 6'b010100;
    localparam zs   = 6'b010101;
    localparam cc   = 6'b010110;
    localparam cs   = 6'b010111;
    localparam oc   = 6'b011000;
    localparam os   = 6'b011001;
    localparam pc   = 6'b011010;
    localparam ps   = 6'b011011;
    localparam nc   = 6'b011100;
    localparam ns   = 6'b011101;
    localparam jmp  = 6'b011110;
    localparam jz   = 6'b011111;
    localparam jnz  = 6'b100000;
    localparam jc   = 6'b100001;
    localparam jnc  = 6'b100010;
    localparam jo   = 6'b100011;
    localparam jno  = 6'b100100;
    localparam jp   = 6'b100101;
    localparam jnp  = 6'b100110;
    localparam jn   = 6'b100111;
    localparam jnn  = 6'b101000;
    localparam psh  = 6'b101001;
    localparam pul  = 6'b101010;
    localparam jsr  = 6'b101011;
    localparam rts  = 6'b101100;

    // alu operations and their values
    localparam ALUref   = 5'd0;  // ref  rx       - REFlect rx               | rx <-  rx
    localparam ALUadd   = 5'd1;  // add  rx, *    - ADD with carry           | rx <-  rx + * + Cin
    localparam ALUadwc  = 5'd2;  // adwc rx, *    - ADd Without Carry        | rx <-  rx + *
    localparam ALUsub   = 5'd3;  // sub  rx, *    - SUBstract with carry     | rx <-  rx - * + Cin (?) ; Note: double check this
    localparam ALUsuwb  = 5'd4;  // sbwc rx, *    - SuBstract Without Carry  | rx <-  rx - *
    localparam ALUmul   = 5'd5;  // mul  rx, *    - MULtiply                 | rx <-  rx * * ; Note: result truncated to 16 bits
    localparam ALUinc   = 5'd6;  // inc  rx       - INCrement                | rx <-  rx + 1
    localparam ALUdec   = 5'd7;  // dec  rx       - DECrement                | rx <-  rx - 1
    localparam ALUchs   = 5'd8;  // chs  rx       - CHange Sign              | rx <- ~rx + 1
    localparam ALUAND   = 5'd9;  // and  rx, *    - bitwise AND              | rx <-  rx & *
    localparam ALUOR    = 5'd10; // or   rx, *    - bitwise OR               | rx <-  rx | *
    localparam ALUNOT   = 5'd11; // not  rx       - bitwise NOT              | rx <- ~rx
    localparam ALUXOR   = 5'd12; // xor  rx, *    - bitwise XOR              | rx <-  rx xor *
    localparam ALUSL    = 5'd13; // sl   rx       - Shift Left               | rx <-  rx << 1
    localparam ALUSR    = 5'd14; // sr   rx       - Shift Right              | rx <-  rx >> 1
    localparam ALUcmp   = 5'd15; // cmp  rx, *    - CoMPare                  | rx - * ; Note: does not write back, only updates flags
    localparam ALUbit   = 5'd16; // bit  rx, *    - BIt Test                 | rx & * ; Note: does not write back, only updates flags
    localparam ALUchangeFlags  = 5'd17; // do nothing to internalResult

    // addressing modes and their values
    localparam direct           = 3'b000;
    localparam immediate        = 3'b001;
    localparam indirect         = 3'b010;
    localparam directIndexed    = 3'b011;
    localparam indirectIndexed  = 3'b100;
    localparam register         = 3'b101;
    localparam registerIndirect = 3'b110;

    // bus drive sources
    localparam programCounterOut      = 3'b001;
    localparam instructionRegisterOut = 3'b010;
    localparam stackOut               = 3'b011;
    localparam ALUOut                 = 3'b100;
    localparam RAMOut                 = 3'b101;

    // micro instruction step counter
    reg [2:0] microInstructionCounter;
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
                        `fetchnext0
                        `latchClear
                    end
                    1: begin
                        `fetchnext1
                        `latchClear
                    end

                    2: begin 
                        `fetchnext2
                        `latchClear
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
                                `latchClear

                            end

                            1: begin

                                bd = progarmCounterOut;
                                marin = 1;
                                `latchClear

                            end

                            2: begin

                                bd = RAMOut;
                                marin = 1;
                                `latchClear

                            end

                            3: begin

                                bd = RAMOut;
                                rfw = 1;
                                rfwa = rx;
                                `latchClear

                            end

                            4: begin

                                `fetchnext0
                                `latchClear

                            end

                            5: begin

                                `fetchnext1
                                `latchClear

                            end

                            6: begin

                                `fetchnext2
                                `latchClear

                            end

                        endcase

                    end

                    immediate: begin

                        case (microInstructionCounter)

                            0: begin
                                microInstructionReset = 0;
                                pcup = 1;
                                `latchClear

                            end
                            1: begin
                                bd = programCounterOut;
                                marin = 1;
                                `latchClear
                            end
                            2: begin
                                rfw = 1;
                                rfwa = rx;
                                bd = RAMOut;
                                `latchClear
                            end
                            3: begin
                                `fenchnext0
                                `latchClear
                            end

                            4: begin
                                `fetchnext1
                                `latchClear
                            end

                            5: begin
                                `fetchnext2
                                `latchClear
                            end

                        endcase

                    end

                    indirect: begin

                        case (micrcoInstructionCounter)

                            0: begin
                                pcup = 1;
                                `latchClear
                            end
                            1: begin
                                bd = programCounterOut;
                                marin = 1;
                                `latchClear
                            end
                            2: begin
                                bd = RAMOut;
                                marin = 1;
                                `latchClear
                            end
                            3: begin
                                bd = RAMOut;
                                marin = 1;
                                `latchClear
                            end
                            4: begin
                                bd = RAMOut;
                                rfw = 1
                                rfwa = rx;
                                `latchClear
                            end
                            5: begin
                                `fetchnext0
                                `latchClear
                            end
                            6: begin
                                `fetchnext1
                                `latchClear
                            end
                            7: begin
                                `fetchnext2
                                `latchClear
                            end

                        endcase

                    end

                    directIndexed: begin

                        case (microInstructionCounter)

                            0: begin
                                pcup = 1;
                                `latchClear
                            end
                            1: begin
                                bd = programCounterOut;
                                bs = 1;
                                raa = ry;
                                fs = ALUadd;
                                `latchClear
                            end
                            2: begin
                                bd = ALUOut;
                                marin = 1;
                                `latchClear
                            end
                            3: begin
                                bd = RAMOut;
                                rfw = 1;
                                rfwa = rx;
                                `latchClear;
                            end
                            4: begin
                                `fetchnext0
                                `latchClear
                            end
                            5: begin
                                `fetchnext1
                                `latchClear
                            end
                            6: begin
                                `fetchnext2
                                `latchClear
                            end

                        endcase

                    end

                    indirectIndexed: begin

                    end

                    register: begin

                    end

                    registerIndirect: begin

                    end

                    default: begin

                        case (microInstructionCounter)

                            0: begin
                                microInstructionReset = 0;
                                `fetchnext0
                                `latchClear
                            end
                            1: begin
                                `fetchnext1
                                `latchClear
                            end
                            2: begin
                                `fetchnext2
                                `latchClear
                            end

                        endcase

                    end

                endcase

            end

            st: begin

                case (am) 

                    register: begin

                        case (microInstructionCounter)

                            0: begin
                                
                                microInstructionReset = 0;
                                rfw = 1;
                                rfwa = ry;
                                raa = rx;
                                `latchClear

                            end

                            1: begin

                                `fetchnext0
                                `latchClear

                            end

                            2: begin

                                `fetchnext1
                                `latchClear 

                            end

                            3: begin

                                `fetchnext2
                                `latchClear

                            end

                        endcase

                    end

                endcase


            end

            add: begin

                case (am) 

                    immediate: begin

                    case (microInstructionCounter)

                        0: begin

                            microInstructionReset = 0;
                            pcup = 1;
                            `latchClear
                            

                        end

                        1: begin

                            bd = programCounterOut;
                            marin = 1;
                            `latchClear 
                            
                        end

                        2: begin

                            bd = RAMOut;
                            bs = 1;
                            fs = ALUadd;
                            raa = rx;
                            `latchClear

                        end

                        3: begin

                            bd = ALUOut;
                            rfw = 1;
                            rfwa = rx;
                            `latchClear

                        end

                        4: begin

                            `fetchnext0
                            `latchClear

                        end

                        5: begin 
                            `fetchnext1
                            `latchClear
                        end

                        6: begin
                            `fetchnext2
                            `latchClear
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
                            `latchClear

                        end

                        1: begin

                            bd = programCounterOut;
                            marin = 1;
                            `latchClear

                        end

                        2: begin

                            bd = RAMOut;
                            pcjmp = 1;
                            `latchClear

                        end

                        3: begin
                            `fetchnext1 // already set pc
                            `latchClear
                        end

                        4: begin
                            `fetchnext2 
                            `latchClear
                        end

                    endcase

                    end

                endcase

            end

            default: begin

                case (microInstructionCounter) 

                    0: begin
                        microInstructionReset = 0;
                        `fetchnext0
                        `latchClear
                    end
                    1: begin
                        `fetchnext1
                        `latchClear
                    end

                    3: begin
                        `fetchnext2
                        `latchClear
                    end

                endcase

            end

        endcase

    end


endmodule
