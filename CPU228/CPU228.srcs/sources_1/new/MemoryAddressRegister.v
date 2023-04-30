// Ethan Thummel | Amir Bahmandar | Fabiola Sore 4/17/23

`timescale 1ns / 1ps

// NOTE: the module may be changed later, depending on how the addressing modes are implemented
// some logic could be added to automaticly index the memory address, instead of them being indexed through the ALU
module MemoryAddressRegister(

    input clk,
    input loadMemoryAddress,
    input [15:0] memoryAddressIn,
    output reg [15:0] memoryAddressOut

    );

    localparam initialAddress = 16'h0000; // what the memory address register starts at

    initial memoryAddressOut = initialAddress;

    always @(posedge clk) begin

        if (loadMemoryAddress == 1) begin
            memoryAddressOut = memoryAddressIn;
        end

    end
endmodule
