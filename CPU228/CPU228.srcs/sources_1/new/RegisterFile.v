// Ethan Thummel | Amir Bahmandar | Fabiola Sore 4/17/23

`timescale 1ns / 1ps

module RegisterFile(

    output [15:0] temp,
    input clk,
    input RegFileWriteEnable, 
    input [2:0] RegFileWriteAddress, 
    input [15:0] RegFileWriteData, 
    input [2:0] ReadAddressA,
    input [2:0] ReadAddressB,
    output [15:0] ReadDataA,
    output [15:0] ReadDataB

    );

    reg [15:0] File [7:0];

    assign ReadDataA = File[ReadAddressA];
    assign ReadDataB = File[ReadAddressB];

    assign temp = File[0];

    always @(posedge clk) begin

        if (RegFileWriteEnable == 1) begin

            File [RegFileWriteAddress] = RegFileWriteData;

        end

    end

endmodule
