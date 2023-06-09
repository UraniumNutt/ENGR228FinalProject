// alu operations and their values
    localparam aluref   = 5'd0;  // ref  rx       - REFlect rx               | rx <-  rx
    localparam aluadd   = 5'd1;  // add  rx, *    - ADD with carry           | rx <-  rx + * + Cin
    localparam aluadwc  = 5'd2;  // adwc rx, *    - ADd Without Carry        | rx <-  rx + *
    localparam alusub   = 5'd3;  // sub  rx, *    - SUBstract with carry     | rx <-  rx - * + Cin (?) ; Note: double check this
    localparam alusuwb  = 5'd4;  // sbwc rx, *    - SuBstract Without Carry  | rx <-  rx - *
    localparam alumul   = 5'd5;  // mul  rx, *    - MULtiply                 | rx <-  rx * * ; Note: result truncated to 16 bits
    localparam aluinc   = 5'd6;  // inc  rx       - INCrement                | rx <-  rx + 1
    localparam aludec   = 5'd7;  // dec  rx       - DECrement                | rx <-  rx - 1
    localparam aluchs   = 5'd8;  // chs  rx       - CHange Sign              | rx <- ~rx + 1
    localparam aluAND   = 5'd9;  // and  rx, *    - bitwise AND              | rx <-  rx & *
    localparam aluOR    = 5'd10; // or   rx, *    - bitwise OR               | rx <-  rx | *
    localparam aluNOT   = 5'd11; // not  rx       - bitwise NOT              | rx <- ~rx
    localparam aluXOR   = 5'd12; // xor  rx, *    - bitwise XOR              | rx <-  rx xor *
    localparam aluSL    = 5'd13; // sl   rx       - Shift Left               | rx <-  rx << 1
    localparam aluSR    = 5'd14; // sr   rx       - Shift Right              | rx <-  rx >> 1
    localparam alucmp   = 5'd15; // cmp  rx, *    - CoMPare                  | rx - * ; Note: does not write back, only updates flags
    localparam alubit   = 5'd16; // bit  rx, *    - BIt Test                 | rx & * ; Note: does not write back, only updates flags
    localparam aluchangeFlags  = 5'd17; // do nothing to internalResult

    

    