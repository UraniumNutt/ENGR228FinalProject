// Ethan Thummel | Amir Bahmandar | Fabiola Sore 4/18/23

`timescale 1ns / 1ps

module RAMTestbench;

    reg clk;
    reg readWrite;
    reg [15:0] address;
    reg [15:0] dataIn;
    wire [15:0] dataOut;

    RAM uut(

        .clk(clk),
        .readWrite(readWrite),
        .address(address),
        .dataIn(dataIn),
        .dataOut(dataOut)

    );

    initial begin
        
        address = 0; #10
        dataIn = 420; readWrite = 1; clk = 1; #10 clk = 0; #10
        readWrite = 0;
        dataIn = 12345; address = 16'h00ff; readWrite = 1; clk = 1; #10 clk = 0;

        #10 readWrite = 0;


    end

endmodule
