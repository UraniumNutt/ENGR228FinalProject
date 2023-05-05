// Ethan Thummel | Amir Bahmandar | Fabiola Sore 4/29/23

`timescale 1ns / 1ps

module CPUTestbench;

    wire [15:0] led;
    reg boardclk;
    wire [15:0] programCounterTest;
    wire [15:0] instructionRegisterTest;
    wire [15:0] stackPointerTest;
    wire [15:0] memoryAddressRegisterTest;
    wire [15:0] ATest;
    wire [15:0] BTest;
    wire [4:0] functionSelectTest;
    wire [15:0] resultTest;
    wire [4:0] flagsTest;

    CPU uut(

        .led(led),
        .boardclk(boardclk),
        .programCounterTest(programCounterTest),
        .instructionRegisterTest(instructionRegisterTest),
        .stackPointerTest(stackPointerTest),
        .memoryAddressRegisterTest(memoryAddressRegisterTest),
        .ATest(ATest),
        .BTest(BTest),
        .functionSelectTest(functionSelectTest),
        .resultTest(resultTest),
        .flagsTest(flagsTest)

    );

    initial begin

        boardclk = 0;
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1;
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1;
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1;
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1;
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1;
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1;
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1;
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1;
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1;
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1;
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1;
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1;
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1;
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1;
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1;
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1;
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1;
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1;
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1;
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1;
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1;
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1;
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1;
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1;
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1;
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1;
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1; 
        #10 boardclk = 0; #10 boardclk = 1;
        
    end

endmodule
