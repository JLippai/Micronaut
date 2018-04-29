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
    input [16:0] readByteAddress,
    input [12:0] readBlockAddress,
    input [12:0] writeBlockAddress,
    input [127:0] pixelBlockWrite,
    output [127:0] pixelBlockRead,
    output [7:0] pixelRead
    );
    
    frameMem frame1(readByteAddress, readBlockAddress, writeBlockAddress, pixelBlockWrite[127:96], pixelBlockWrite[95:64], pixelBlockWrite[63:32], pixelBlockWrite[31:0], pixelBlockRead[127:96], pixelBlockRead[95:64], pixelBlockRead[63:32], pixelBlockRead[31:0], pixelRead);
    
endmodule
