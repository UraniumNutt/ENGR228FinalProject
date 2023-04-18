// Ethan Thummel | Amir Bahmandar | Fabiola Sore 4/17/23

`timescale 1ns / 1ps

module RegisterFileTestbench;

    reg clk;
    reg WriteEnable;
    reg [15:0] WriteAddress;
    reg [15:0] WriteData;
    reg [15:0] ReadAddressA;
    reg [15:0] ReadAddressB;
    wire [15:0] ReadDataA;
    wire [15:0] ReadDataB;

    RegisterFile uut(

        .clk(clk),
        .WriteEnable(WriteEnable),
        .WriteAddress(WriteAddress),
        .WriteData(WriteData),
        .ReadAddressA(ReadAddressA),
        .ReadAddressB(ReadAddressB),
        .ReadDataA(ReadDataA),
        .ReadDataB(ReadDataB)

    );

    initial begin

        WriteAddress = 3'b000; WriteData = 16'd42; WriteEnable = 1; #10
        clk = 1; #10 clk = 0;
        WriteEnable = 0;
        WriteAddress = 3'b111; WriteData = 16'd420; WriteEnable = 1; #10
        clk = 1; #10 clk = 0;
        WriteEnable = 0;


        ReadAddressA = 3'b000;
        ReadAddressB = 3'b111;

    end

endmodule
