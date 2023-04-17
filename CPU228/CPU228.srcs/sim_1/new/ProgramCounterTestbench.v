// Ethan Thummel | Amir Bahmandar | Fabiola Sore 4/17/23

`timescale 1ns / 1ps

module ProgramCounterTestbench;

    reg clk;
    reg CountUp;
    reg Jump;
    reg [15:0] addressIn;
    wire [15:0] addressOut;

    ProgramCounter uut(

        .clk(clk),
        .CountUp(CountUp),
        .Jump(Jump),
        .addressIn(addressIn),
        .addressOut(addressOut)

    );

    initial begin

        CountUp = 1; 
        #10 clk = 1; #10 clk = 0;
        #10 clk = 1; #10 clk = 0;
        #10 clk = 1; #10 clk = 0;

        CountUp = 0;
        addressIn = 16'hff; Jump = 1;
        #10 clk = 1; #10 clk = 0;
        Jump = 0; CountUp = 1;
        #10 clk = 1; #10 clk = 0;
        #10 clk = 1; #10 clk = 0;
        #10 clk = 1; #10 clk = 0;


    end


endmodule
