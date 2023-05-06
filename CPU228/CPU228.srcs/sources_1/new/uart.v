// Ethan Thummel | Amir Bahmandar | Fabiola Sore 5/6/23

`timescale 1ns / 1ps

module uart(

    input boardclk,
    input clk,
    input RsRx,
    input [7:0] transmitIn,
    output reg [7:0] receiveOut,
    output reg [1:0] uartflags,
    output reg RsTx

    );

    // 9600 baud, 8 data bits, no parity, 1 stop (+ 1 stop)

    localparam baudRate = 9600;
    localparam sampleRate = 16;
    localparam boardclkRate = 100 * 10 ^ 6;


endmodule
