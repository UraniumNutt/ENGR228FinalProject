// Ethan Thummel | Amir Bahmandar | Fabiola Sore 4/13/23

`timescale 1ns / 1ps

module CPU(

    input clk,
    input btnC,
    input [15:0] sw,
    output [15:0] led

    );

    wire [15:0] dataIn = 0;
    wire readWrite = btnC;

    RAM ram(

        .clk(clk),
        .readWrite(readWrite),
        .address(sw),
        .dataIn(dataIn),
        .dataOut(led)

    );
    
endmodule
