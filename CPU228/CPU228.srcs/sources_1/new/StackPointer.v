// Ethan Thummel | Amir Bahmandar | Fabiola Sore 4/17/23

`timescale 1ns / 1ps

module StackPointer(

    input clk,
    input CountUp,
    input CountDown,
    output [15:0] TopOfStack

    );

    localparam baseOfStack = 16'h8000; // where in memory the stack should be located. change as needed

    reg [15:0] pointer;
    initial pointer = baseOfStack;

    assign TopOfStack = pointer;

    always @(posedge clk) begin

        if (CountUp == 1) begin
            pointer = pointer + 1;
        end
        
        if (CountDown == 1) begin
            pointer = pointer - 1;
        end

    end
endmodule
