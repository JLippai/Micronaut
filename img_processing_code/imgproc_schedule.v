`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2018 12:24:08 PM
// Design Name: 
// Module Name: imgproc_schedule
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
`define PIXELS_PER_BLOCK 16
`define NUMBER_OF_BLOCKS 4800

module imgproc_scheduled(
    input clk,
    input [127:0] readPixel,
    input [127:0] bgPixel,
    output reg [2:0] currentFrame,
    output reg [12:0] readAddress,
    output reg [12:0] writeAddress,
    output reg [127:0] subtractedPixel,
    output reg writeEn,
    output [15:0] goodCnt,
    output [15:0] badCnt
    );
    wire [127:0] classifiedPixel;
    genvar i;
    generate for (i = 0; i < `PIXELS_PER_BLOCK; i = i+1) begin
        px_classify gen_px_classify(readPixel[8*i+:8], bgPixel[8*i+:8], 7'd10, classifiedPixel[8*i+:8]);
    end endgenerate
    
    always @ (posedge clk) begin
        readAddress <= (readAddress < `NUMBER_OF_BLOCKS - 1) ? readAddress + 1 : 0;
        writeAddress <= readAddress;
        writeEn <= (readAddress == `NUMBER_OF_BLOCKS - 1);
        subtractedPixel <= classifiedPixel;
    end
    initial begin
        readAddress <= 0;
        currentFrame <= 0;
        writeAddress <= 0;
        writeEn <= 0;
        subtractedPixel <= 0;
    end
endmodule
