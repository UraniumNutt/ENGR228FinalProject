// macros for jump instructions

// carry overflow zero pos neg
    localparam alucarry    = 4;
    localparam aluoverflow = 3;
    localparam aluzero     = 2;
    localparam alupos      = 1;
    localparam aluneg      = 0;


`define jumpOnSet(condition) \
case (flags[condition]) \
    0: begin \
        case (am) \
            direct: begin \
                case (ucode) \
                    0: begin \
                        programCounter = programCounter + 2; \
                        ucode = ucode + 1; \
                    end \
                    1: begin \
                        instructionRegister = ram[programCounter]; \
                        ucode = 0; \
                    end \
                endcase \
            end \
        endcase \
    end \
    1: begin \
        case (am) \
            direct: begin \
                case (ucode) \
                    0: begin \
                        memoryAddressRegister = ram[programCounter + 1]; \
                        programCounter = memoryAddressRegister; \
                        ucode = ucode + 1; \
                    end \
                    1: begin \
                        instructionRegister = ram[programCounter]; \
                        ucode = 0; \
                    end \
                endcase \
            end \
        endcase \
    end \
endcase

`define jumpOnClear(condition) \
case (flags[condition]) \
    0: begin \
        case (am) \
            direct: begin \
                case (ucode) \
                    0: begin \
                        memoryAddressRegister = ram[programCounter + 1]; \
                        programCounter = memoryAddressRegister; \
                        ucode = ucode + 1; \
                    end \
                    1: begin \
                        instructionRegister = ram[programCounter]; \
                        ucode = 0; \
                    end \
                endcase \
            end \
        endcase \
    end \
    1: begin \
        case (am) \
            direct: begin \
                case (ucode) \
                    0: begin \
                        programCounter = programCounter + 2; \
                        ucode = ucode + 1; \
                    end \
                    1: begin \
                        instructionRegister = ram[programCounter]; \
                        ucode = 0; \
                    end \
                endcase \
            end \
        endcase \
    end \
endcase