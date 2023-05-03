// Ethan Thummel | Amir Bahmandar | Fabiola Sore 4/27/23

`timescale 1ns / 1ps

module Bus(

    input [2:0] driveSelect,
    input [15:0] input0,
    input [15:0] input1,
    input [15:0] input2,
    input [15:0] input3,
    input [15:0] input4,
    input [15:0] input5,
    input [15:0] input6,
    input [15:0] input7,
    output reg [15:0] busDrive

    );

    always @(*) begin
        
        case (driveSelect)

            0: busDrive = input0;
            1: busDrive = input1;
            2: busDrive = input2;
            3: busDrive = input3;   
            4: busDrive = input4;
            5: busDrive = input5;
            6: busDrive = input6;
            7: busDrive = input7;

        endcase

    end

endmodule
