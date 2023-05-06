// macros for alu instructions

`define aluOneArg(operation) \
    case (ucode) \
        0: begin \
            A = registerFile[rx]; \
            B = 0; \
            constant = 0; \
            bSource = 0; \
            functionSelect = operation; \
            ucode = ucode + 1; \
        end \
        1: begin \
            ucode = ucode + 1; \
        end \
        2: begin \
            registerFile[rx] = result; \
            flags = currentFlags; \
            programCounter = programCounter + 1; \
            ucode = ucode + 1; \
        end \
        3: begin \
            instructionRegister = ram[programCounter]; \
            ucode = 0; \
        end \
    endcase

`define aluTwoArg(operation) \
    case (am) \
            register: begin \
                case (ucode) \
                    0: begin \
                        A = registerFile[rx]; \
                        B = registerFile[ry]; \
                        constant = 0; \
                        bSource = 0; \
                        functionSelect = operation; \
                        ucode = ucode + 1; \
                    end \
                    1: begin \
                        ucode = ucode + 1; \
                    end \
                    2: begin \
                        registerFile[rx] = result; \
                        flags = currentFlags; \
                        programCounter = programCounter + 1; \
                        ucode = ucode + 1; \
                    end \
                    3: begin \
                        instructionRegister = ram[programCounter]; \
                        ucode = 0; \
                    end \
                endcase \
            end \
            immediate: begin \
                case (ucode) \
                    0: begin \
                        A = registerFile[rx]; \
                        B = 0; \
                        constant = ram[programCounter + 1]; \
                        bSource = 1; \
                        functionSelect = operation; \
                        ucode = ucode + 1; \
                    end \
                    1: begin \
                        ucode = ucode + 1; \
                    end \
                    2: begin \
                        registerFile[rx] = result; \
                        flags = currentFlags; \
                        programCounter = programCounter + 2; \
                        ucode = ucode + 1; \
                    end \
                    3: begin \
                        instructionRegister = ram[programCounter]; \
                        ucode = 0; \
                    end \
                endcase \
            end \
    endcase