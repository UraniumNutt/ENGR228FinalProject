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
        
        readWrite = 1;
        #10 address = 0; 
        #10 address = 1; 
        #10 address = 2; 
        #10 address = 3; 


    end

endmodule
