// Ethan Thummel | Amir Bahmandar | Fabiola Sore 4/17/23

`timescale 1ns / 1ps

module StackPointerTestbench;

    reg clk;
    reg CountUp;
    reg CountDown;
    wire [15:0] TopOfStack;

    StackPointer uut(

        .clk(clk),
        .CountUp(CountUp),
        .CountDown(CountDown),
        .TopOfStack(TopOfStack)

    );

    initial begin

        CountUp = 1;
        #10 clk = 1; #10 clk = 0;
        #10 clk = 1; #10 clk = 0;
        #10 clk = 1; #10 clk = 0;
        CountUp = 0;
        #10 clk = 1; #10 clk = 0;
        CountDown = 1;
        #10 clk = 1; #10 clk = 0;
        #10 clk = 1; #10 clk = 0;
        #10 clk = 1; #10 clk = 0;
        CountDown = 0;


    end

endmodule
