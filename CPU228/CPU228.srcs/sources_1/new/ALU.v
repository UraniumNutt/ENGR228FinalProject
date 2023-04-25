// Ethan Thummel | Amir Bahmandar | Fabiola Sore 4/19/23

`timescale 1ns / 1ps

module ALU(

    input clk,
    input signed [15:0] A,
    input signed [15:0] B,
    input [4:0] functionSelect,
    input [4:0] overwriteFlagsMask,
    input [4:0] setFlagBits, // carry overflow zero pos neg
    output signed [15:0] result,
    output reg [4:0] currentFlags    // carry overflow zero pos neg
    
    );

    // what the current state of the flags is, and how it should start
    initial currentFlags = 5'b00100;
    // a 32 bit result
    reg signed [31:0] internalResult;
    assign result = internalResult[15:0];

    // instruction aliases
    localparam ref   = 5'd0;  // ref  rx       - REFlect rx               | rx <-  rx
    localparam add   = 5'd1;  // add  rx, *    - ADD with carry           | rx <-  rx + * + Cin
    localparam adwc  = 5'd2;  // adwc rx, *    - ADd Without Carry        | rx <-  rx + *
    localparam sub   = 5'd3;  // sub  rx, *    - SUBstract with carry     | rx <-  rx - * + Cin (?) ; Note: double check this
    localparam suwb  = 5'd4;  // sbwc rx, *    - SuBstract Without Carry  | rx <-  rx - *
    localparam mul   = 5'd5;  // mul  rx, *    - MULtiply                 | rx <-  rx * * ; Note: result truncated to 16 bits
    localparam inc   = 5'd6;  // inc  rx       - INCrement                | rx <-  rx + 1
    localparam dec   = 5'd7;  // dec  rx       - DECrement                | rx <-  rx - 1
    localparam chs   = 5'd8;  // chs  rx       - CHange Sign              | rx <- ~rx + 1
    localparam AND   = 5'd9;  // and  rx, *    - bitwise AND              | rx <-  rx & *
    localparam OR    = 5'd10; // or   rx, *    - bitwise OR               | rx <-  rx | *
    localparam NOT   = 5'd11; // not  rx       - bitwise NOT              | rx <- ~rx
    localparam XOR   = 5'd12; // xor  rx, *    - bitwise XOR              | rx <-  rx xor *
    localparam SL    = 5'd13; // sl   rx       - Shift Left               | rx <-  rx << 1
    localparam SR    = 5'd14; // sr   rx       - Shift Right              | rx <-  rx >> 1
    localparam cmp   = 5'd15; // cmp  rx, *    - CoMPare                  | rx - * ; Note: does not write back, only updates flags
    localparam bit   = 5'd16; // bit  rx, *    - BIt Test                 | rx & * ; Note: does not write back, only updates flags
    localparam changeFlags  = 5'd17; // do nothing to internalResult

    always @(posedge clk) begin
        
        case (functionSelect)
            
            ref:   internalResult = A;
            add:   internalResult = A + B + currentFlags[4];  // add carry flag
            adwc:  internalResult = A + B;
            sub:   internalResult = A - B - currentFlags[4];
            suwb:  internalResult = A - B;
            mul:   internalResult = (A * B);            // truncate NOTE: need to fix mul flag sets
            inc:   internalResult = A + 1;
            dec:   internalResult = A - 1;
            chs:   internalResult = ~A + 1;
            AND:   internalResult = A & B;
            OR:    internalResult = A | B;
            NOT:   internalResult = ~A;
            XOR:   internalResult = A ^ B;
            SL:    internalResult = A << 1;
            SR:    internalResult = A >> 1;  
            cmp:   internalResult = A - B;                     
            bit:   internalResult = A * B;               

        endcase
        
        // explicitly change flags
        if (functionSelect == changeFlags) begin
            currentFlags = setFlagBits & overwriteFlagsMask;
        end

        else begin

            // carry flag
            if (internalResult > 65536) begin
                currentFlags[4] = 1;
            end

            else begin
                currentFlags[4] = 0;
            end

            // overflow flag
            if (functionSelect == mul) begin
                if (internalResult > 32767 || internalResult < -32768) begin
                    currentFlags[3] = 1;
                end

                else begin
                    currentFlags[3] = 0;
                end
            end

            if (functionSelect != mul) begin
                if ((internalResult[15] == 0 && A[15] == 1 && B[15] == 1) || (internalResult[15] == 1 && A[15] == 0 && B[15] == 0)) begin
                currentFlags[3] = 1;
                end

            else begin
                currentFlags[3] = 0;
                end
            end

            //zero
            if (internalResult[15:0] == 0) begin
                currentFlags[2] = 1;
            end

            else begin
                currentFlags[2] = 0;
            end

            // pos / neg flags

            if (internalResult[15:0] > 0) begin
                currentFlags[1] = 1;
            end

            else begin
                currentFlags[1] = 0;
            end

            if (internalResult[15:0] < 0) begin
                currentFlags[0] = 1;
            end

            else begin
                currentFlags[0] = 0;
            end

        end

    end



endmodule
