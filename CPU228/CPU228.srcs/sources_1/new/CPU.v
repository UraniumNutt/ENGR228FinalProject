// Ethan Thummel | Amir Bahmandar | Fabiola Sore 4/13/23

`timescale 1ns / 1ps

module CPU(

    input sw, clk,
    output reg led

    );

    always @(posedge clk) begin
        led = sw;
    end

endmodule
