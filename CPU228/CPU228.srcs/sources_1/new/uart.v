// Ethan Thummel | Amir Bahmandar | Fabiola Sore 5/6/23

`timescale 1ns / 1ps

module uart(

    input boardclk,
    input clk,
    input RsRx,
    input newTransmit,
    input [7:0] transmitIn,
    output reg [7:0] receiveOut,
    output reg [1:0] uartflags, // transmit empty, receive full
    output reg RsTx

    );

    reg [7:0] transmitBuffer;
    reg [7:0] receiveBuffer;

    reg [9:0] clkCounter;
    initial clkCounter = 0;

    reg [2:0] bitIndex;
    initial bitIndex = 0;

    initial uartflags = 2'b10;

    // 115200 baud, 8 data bits, no parity, 1 stop (+ 1 stop)

    localparam clksPerBit = 868; // 100Mhz / 115200
    localparam halfclksPerBit = 434;

    // states of the transmiter state machine
    localparam transmitStateIdle     = 2'b00;
    localparam transmitStateStartBit = 2'b01;
    localparam transmitStateData     = 2'b10;
    localparam transmitStateStopBit  = 2'b11;

    reg [1:0] transmiterState;
    initial transmiterState = transmitStateIdle;

    always @(posedge clk) begin
        
        case (transmiterState)

            transmitStateIdle: begin

                clkCounter <= 0; // reset counter
                bitIndex <= 0; // reset bit index
                RsTx <= 1; // bring tx line to 1 for idle

                if (newTransmit == 1) begin

                    uartflags[1] <= 0; // transmit full
                    transmitBuffer <= transmitIn; // load transmit buffer
                    transmiterState <= transmitStateStartBit; // switch to the transmit state

                end

                else begin

                    transmiterState <= transmitStateIdle;

                end

            end

            transmitStateStartBit: begin

                RsTx <= 0; // start bit

                if (clkCounter < clksPerBit) begin
                    clkCounter <= clkCounter + 1;
                    transmiterState <= transmitStateStartBit;
                end

                else begin

                    clkCounter <= 0;
                    transmiterState <= transmitStateData;

                end

            end

            transmitStateData: begin

                RsTx <= transmitBuffer[bitIndex];

                if (clkCounter < clksPerBit) begin

                    clkCounter <= clkCounter + 1;
                    transmiterState <= transmitStateData;

                end

                else begin

                    clkCounter <= 0;
                    
                    if (bitIndex < 7) begin

                        bitIndex <= bitIndex + 1;
                        transmiterState <= transmitStateData;

                    end

                    else begin

                        bitIndex <= 0;
                        transmiterState <= transmitStateStopBit;

                    end

                end

            end

            transmitStateStopBit: begin

                RsTx <= 1;

                if (clkCounter < clksPerBit) begin
                    clkCounter <= clkCounter + 1;
                    transmiterState <= transmitStateStopBit;
                end

                else begin

                    clkCounter <= 0;
                    uartflags[1] = 1; // transmit empty
                    transmiterState <= transmitStateIdle;

                end

            end

        endcase

    end





endmodule
