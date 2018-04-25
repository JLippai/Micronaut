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


module MemTest(
    input GCLK,
    output reg LD0
    //output reg [71:0] JoshLRead
    //output reg [7:0] rgb
    //input [ JoshLReadAddress
    //input [63999:0] VGAReadAddress
    //output reg count = 128'b0
    );
    reg [76799:0] count = 76799'b0;
    wire [127:0] pixelblock;
    
    frameMem frame1(GCLK, count, pixelblock[127:96], pixelblock[95:64], pixelblock[63:31], pixelblock[31:0]);
    
    always@(posedge GCLK)
    begin 
        if(count == {76799{1'b1}} && LD0==1'b0)
        begin
            count = 76799'b0;
            LD0 = 1'b1;
        end
        else if(count == {76799{1'b1}} && LD0==1'b1)
        begin
            count = 128'b0;
            LD0 = 1'b1;
        end
        else
        begin
            count = count + 3'd4;
        end
    end
    
    //assign pixelblock = count;
    
endmodule
