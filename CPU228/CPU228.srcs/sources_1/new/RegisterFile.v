// Ethan Thummel | Amir Bahmandar | Fabiola Sore 4/17/23

`timescale 1ns / 1ps

module RegisterFile(

    input clk,
    input WriteEnable, 
    input [15:0] WriteAddress, 
    input [15:0] WriteData, 
    input [15:0] ReadAddressA,
    input [15:0] ReadAddressB,
    input [15:0] ReadAddressIndex,
    output [15:0] ReadDataA,
    output [15:0] ReadDataB,
    output [15:0] ReadDataIndex

    );

    reg [15:0] File [7:0];

    assign ReadDataA = File[ReadAddressA];
    assign ReadDataB = File[ReadAddressB];
    assign ReadDataIndex = File[ReadAddressIndex];

    always @(posedge clk) begin

        if (WriteEnable == 1) begin

            File [WriteAddress] = WriteData;

        end

    end

endmodule
