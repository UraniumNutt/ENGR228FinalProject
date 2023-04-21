// Ethan Thummel | Amir Bahmandar | Fabiola Sore 4/18/23

`timescale 1ns / 1ps

module RAM(

    input clk,
    input readWrite,
    input [15:0] address,
    input [15:0] dataIn,
    output [15:0] dataOut

    );

    reg [15:0] ram [1023:0];

    // there is not enough room on the FPGA for 64k X 16 bit memory, so just do 1k X 16
    assign dataOut = ram[address[9:0]];

    always @(posedge clk) begin
        
        if (readWrite == 1) begin
            ram[address[9:0]] = dataIn;
        end

    end

    initial begin
        $readmemb("/home/uraniumnutt/Documents/VerilogProjects/ENGR228FinalProject/compiler/test.bin", ram);
    end
endmodule
