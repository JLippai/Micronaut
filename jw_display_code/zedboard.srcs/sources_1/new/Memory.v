`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2018 08:41:40 PM
// Design Name: 
// Module Name: MemTest
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Memory(
    input    [2:0] frameSelBlock,
    input   [12:0] readBlockAddress,
    input    [2:0] frameSelByte,
    input   [16:0] readByteAddress,
    output [127:0] pixelBlockOut,
    output   [7:0] pixelOut,
    input   [12:0] writeBlockAddress,
    input  [127:0] pixelBlockIn,
    input          writeEn
    );
    
    frameMem frame1(readBlockAddress, readByteAddress, pixelBlockOut[127:96], pixelBlockOut[95:64], pixelBlockOut[63:32], pixelBlockOut[31:0], pixelOut);
    
endmodule
