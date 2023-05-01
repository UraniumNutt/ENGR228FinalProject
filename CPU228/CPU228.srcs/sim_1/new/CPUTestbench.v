// Ethan Thummel | Amir Bahmandar | Fabiola Sore 4/29/23

`timescale 1ns / 1ps

module CPUTestbench;

    wire [15:0] led;
    reg boardclk;
    wire [15:0] instructionOutTest; 
    wire [4:0] currentFlagsTest;        
    wire programCounterCountUpTest;     
    wire programCounterJumpTest;        
    wire loadInstructionTest;           
    wire loadMemoryAddressTest;         
    wire StackCountUpTest;              
    wire StackCountDownTest;            
    wire RegFileWriteEnableTest;        
    wire [2:0] RegFileWriteAddressTest; 
    wire [2:0] ReadAddressATest;        
    wire [2:0] ReadAddressBTest;        
    wire [4:0] functionSelectTest;      
    wire [4:0] overwriteFlagsMaskTest;  
    wire [4:0] setFlagBitsTest;         
    wire RAMWriteReadTest;              
    wire bSourceTest;                  
    wire [2:0] busDriveTest;
    wire [15:0] busTest;

    CPU uut(

        .led(led),
        .boardclk(boardclk),
        .instructionOutTest(instructionOutTest),
        .currentFlagsTest(currentFlagsTest),
        .programCounterCountUpTest(programCounterCountUpTest),
        .programCounterJumpTest(programCounterJumpTest),
        .loadInstructionTest(loadInstructionTest),
        .loadMemoryAddressTest(loadMemoryAddressTest),
        .StackCountUpTest(StackCountUpTest),
        .StackCountDownTest(StackCountDownTest),
        .RegFileWriteEnableTest(RegFileWriteEnableTest),
        .RegFileWriteAddressTest(RegFileWriteAddressTest),
        .ReadAddressATest(ReadAddressATest),
        .ReadAddressBTest(ReadAddressBTest),
        .functionSelectTest(functionSelectTest),
        .overwriteFlagsMaskTest(overWriteFlagsMaskTest),
        .setFlagBitsTest(setFlagBitsTest),
        .RAMWriteReadTest(RAMWritereadTest),
        .bSourceTest(bSourceTest),
        .busDriveTest(busDriveTest),
        .busTest(busTest)

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

    end

endmodule
