// Ethan Thummel | Amir Bahmandar | Fabiola Sore 4/25/23

`timescale 1ns / 1ps

// The clkModule takes the 100MHz board clk and slows it down
module clkModule(

    input inputclk,
    output reg clk

    );

    reg [7:0] counter = 0;
    initial clk = 0;

    always @(posedge inputclk) begin
        counter = counter + 1;

        if (counter == 49) begin
            counter = 0;
            clk = ~clk;
        end
    end
endmodule
