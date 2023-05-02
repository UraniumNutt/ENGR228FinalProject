// Ethan Thummel | Amir Bahmandar | Fabiola Sore 4/18/23

`timescale 1ns / 1ps

module Memory(

    input clk,
    input readWrite,
    input [15:0] address,
    input [15:0] dataIn,
    output [15:0] dataOut

    );

    reg [15:0] ram [1023:0];
    // reg [15:0] outputBuffer;

    // assign outputBuffer = ram[address];
    assign dataOut = ram[address];

    always @(posedge clk) begin
        
        // outputBuffer = ram[address];
        
        if (readWrite == 1) begin
            ram[address] = dataIn;
        end

        
        
        

    end

    // always @(negedge clk) begin
    //     dataOut = ram[address];
    // end

    // always @(negedge clk) begin
    //     //dataOut = outputBuffer;
    //     outputBuffer = ram[address];
    // end

    initial begin
        $readmemb("/home/uraniumnutt/Documents/VerilogProjects/ENGR228FinalProject/compiler/output.txt", ram);
    end
endmodule
