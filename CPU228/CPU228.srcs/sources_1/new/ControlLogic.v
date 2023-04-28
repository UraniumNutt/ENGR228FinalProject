// Ethan Thummel | Amir Bahmandar | Fabiola Sore 4/27/23

`timescale 1ns / 1ps

module ControlLogic(

    input clk,
    input [15:0] instructionOut,
    input [4:0] currentFlags,
    output programCounterCountUp,
    output programCounterJump,
    output loadInstruction,
    output loadMemoryAddress,
    output StackCountUp,
    output StackCountDown,
    output RegFileWriteEnable,
    output [2:0] RegFileWriteAddress,
    output [2:0] ReadAddressA,
    output [2:0] ReadAddressB,
    output [4:0] functionSelect,
    output [4:0] overwriteFlagsMask,
    output [4:0] setFlagBits,
    output RAMreadWrite,
    output [2:0] busDrive

    );

    wire opcode = instructionOut[15:10];
    wire rx     = instrcutionOut[9:7];
    wire am     = instructionOut[6:4];
    wire ry     = instructionOut[3:1];

    wire rxWrite = {7'b0000000, rx, 25'b0000000000000000000000000};
    wire ryWrite = {7'b0000000, ry, 25'b0000000000000000000000000};

    wire rxReadA = {10'b00000000000, rx, 22'b0000000000000000000000};
    wire rxReadB = {13'b00000000000000, rx, 19'b0000000000000000000};
    wire ryReadA = {10'b00000000000, ry, 22'b0000000000000000000000};
    wire ryReadB = {13'b00000000000000, ry, 19'b0000000000000000000};

    reg [34:0] controlWord;
    initial controlWord = 0;

    assign programCounterCountUp = controlWord[34];
    assign programCounterJump    = controlWord[33];
    assign loadInstruction       = controlWord[32];
    assign loadMemoryAddress     = controlWord[31];
    assign StackCountUp          = controlWord[30];
    assign StackCountDown        = controlWord[29];
    assign RegFileWriteEnable    = controlWord[28];
    assign RegFileWriteAddress   = controlWord[27:25];
    assign ReadAddressA          = controlWord[24:22];
    assign ReadAddressB          = controlWord[21:19];
    assign functionSelect        = controlWord[18:14];
    assign overwriteFlagsMask    = controlWord[13:9];
    assign setFlagBits           = controlWord[8:4];
    assign RAMreadWrite          = controlWord[3];
    assign busDrive              = controlWord[2:0];

    localparam emptyControlWord      = 35'b00000000000000000000000000000000000;

    localparam PCup                  = 35'b10000000000000000000000000000000000;   //1
    localparam PCJump                = 35'b01000000000000000000000000000000000;   //1
    localparam IRin                  = 35'b00100000000000000000000000000000000;   //1
    localparam MAin                  = 35'b00010000000000000000000000000000000;   //1
    localparam SPup                  = 35'b00001000000000000000000000000000000;   //1
    localparam SPdown                = 35'b00000100000000000000000000000000000;   //1
    localparam RFWriteEnable         = 35'b00000010000000000000000000000000000;   //1
    localparam RFWriteAddress        = 35'b00000001110000000000000000000000000;   //3
    localparam RFReadA               = 35'b00000000001110000000000000000000000;   //3
    localparam RFReadB               = 35'b00000000000001110000000000000000000;   //3
    localparam ALUFunctionSelect     = 35'b00000000000000001111100000000000000;   //5
    localparam ALUOverwriteFlagsMask = 35'b00000000000000000000011111000000000;   //5
    localparam ALUsetFlagBits        = 35'b00000000000000000000000000111110000;   //5
    localparam RAMRW                 = 35'b00000000000000000000000000000001000;   //1
    localparam BUSSelect             = 35'b00000000000000000000000000000000111;   //3
    
    localparam r0 = 3'b000;
    localparam r1 = 3'b001;
    localparam r2 = 3'b010;
    localparam r3 = 3'b011;
    localparam r4 = 3'b100;
    localparam r5 = 3'b101;
    localparam r6 = 3'b110;
    localparam r7 = 3'b111;

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

    localparam direct           = 3'b000;
    localparam immediate        = 3'b001;
    localparam indirect         = 3'b010;
    localparam directIndexed    = 3'b011;
    localparam indirectIndexed  = 3'b100;
    localparam register         = 3'b101;
    localparam registerIndirect = 3'b110;

    localparam progarmCounterOut      = 3'b000;
    localparam instructionRegisterOut = 3'b001;
    localparam stackOut               = 3'b010;
    localparam ALUOut                 = 3'b011;
    localparam RAMOut                 = 3'b100;

    reg [2:0] microInstructionCounter;
    initial microInstructionCounter = 0;

    reg microInstructionCounterReset;
    initial microInstructionCounterReset = 0;

    always @(posedge clk) begin
        if (microInstructionCounterReset == 1) begin
            microInstructionCounter = 0;
            microInstructionCounterReset = 0;
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
                        controlWord = PCup;
                    end
                    1: begin
                        controlWord = (BUSSelect && progarmCounterOut) || IRin;
                    end
                    2: begin
                        controlWord = emptyControlWord;
                        microInstructionCounterReset = 1;
                    end

                endcase

            end

            ld: begin

                case (am) 

                    immediate: begin

                        case (microInstructionCounter)

                            0: begin
                                controlWord = PCup || (BUSSelect && progarmCounterOut) || MAin;
                            end
                            1: begin
                                controlWord = (RFWriteAddress && rxWrite) || RFWriteEnable || (BUSSelect && RAMOut)
                            end
                            2: begin
                                
                            end

                        endcase

                    end

                    default: begin

                        case (microInstructionCounter)

                            0: begin
                                controlWord = emptyControlWord;
                                microInstructionCounterReset = 1;
                            end

                        endcase

                    end

                endcase

            end

            default: begin

                case (microInstructionCounter) 

                    0: begin
                        controlWord = emptyControlWord;
                        microInstructionCounterReset = 1; 
                    end

                endcase

            end

        endcase

    end


endmodule
