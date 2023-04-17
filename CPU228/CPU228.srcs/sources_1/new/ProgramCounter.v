// Ethan Thummel | Amir Bahmandar | Fabiola Sore 4/17/23

`timescale 1ns / 1ps

module ProgramCounter(

    input clk,
    input CountUp,
    input Jump, // Load
    input [15:0] addressIn,
    output [15:0] addressOut

    );

    reg [15:0] counter;
    initial counter = 0;

    assign addressOut = counter;

    always @(posedge clk) begin

        if (CountUp == 1) begin
            counter = counter + 1;
        end 
        
        if (Jump == 1) begin
            counter = addressIn;
        end

    end

endmodule
