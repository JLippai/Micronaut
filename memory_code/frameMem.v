`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2018 02:45:43 PM
// Design Name: 
// Module Name: frameMem
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

`define ONE_ROW 320
`define TWO_ROWS 640
`define THREE_ROWS 980

`define ONE_COL 8
`define TWO_COLS 16
`define THREE_COLS 24

module frameMem(
        input clk,
        input [4799:0] readAddress,
        output reg [31:0] pixBlockRow0,
        output reg [31:0] pixBlockRow1,
        output reg [31:0] pixBlockRow2,
        output reg [31:0] pixBlockRow3
    );
    
    reg [7:0] memFile [76799:0]; //byte addressable and 320x240 big
    reg [2:0] count;
    
    initial
    begin
        $readmemh("logo-Cidar-Color320_240.list", memFile);
    end
    
    always@(posedge clk)
    //loading up the output blocks with the correct addresses from the memFile
    //check these reads to ensure I'm not addressing backwards (little endian/big endian screwery)
    begin
        if(count<3'd4)
        begin
            if(count==0)    //First collumn of pixels
            begin
                pixBlockRow0[((4)*8-1):((4)*8-5)] = memFile[readAddress*16];
                pixBlockRow1[((4)*8-1):((4)*8-5)] = memFile[(readAddress*16+`ONE_ROW)];
                pixBlockRow2[((4)*8-1):((4)*8-5)] = memFile[(readAddress*16+`TWO_ROWS)];
                pixBlockRow3[((4)*8-1):((4)*8-5)] = memFile[(readAddress*16+`THREE_ROWS)];
            end
            
            else if(count==1)   //Second collumn of pixels
            begin
                pixBlockRow0[((3)*8-1):((3)*8-5)] = memFile[(readAddress)*16+`ONE_COL];
                pixBlockRow1[((3)*8-1):((3)*8-5)] = memFile[((readAddress)*16+`ONE_ROW+`ONE_COL)];
                pixBlockRow2[((3)*8-1):((3)*8-5)] = memFile[(readAddress*16+`TWO_ROWS+`ONE_COL)];
                pixBlockRow3[((3)*8-1):((3)*8-5)] = memFile[(readAddress*16+`THREE_ROWS+`ONE_COL)];
            end
            
            else if(count==2)   //Third collumn of pixels
            begin
                pixBlockRow0[((2)*8-1):((2)*8-5)] = memFile[readAddress*16+`TWO_COLS];
                pixBlockRow1[((2)*8-1):((2)*8-5)] = memFile[readAddress*16+`ONE_ROW+`TWO_COLS];
                pixBlockRow2[((2)*8-1):((2)*8-5)] = memFile[readAddress*16+`TWO_ROWS+`TWO_COLS];
                pixBlockRow3[((2)*8-1):((2)*8-5)] = memFile[readAddress*16+`THREE_ROWS+`TWO_COLS];
            end
                        
            else if(count==3)   //Fourth collumn of pixels
            begin
                pixBlockRow0[((1)*8-1):((1)*8-5)] = memFile[readAddress*16+`THREE_COLS];
                pixBlockRow1[((1)*8-1):((1)*8-5)] = memFile[readAddress*16+`ONE_ROW+`THREE_COLS];
                pixBlockRow2[((1)*8-1):((1)*8-5)] = memFile[readAddress*16+`TWO_ROWS+`THREE_COLS];
                pixBlockRow3[((1)*8-1):((1)*8-5)] = memFile[readAddress*16+`THREE_ROWS+`THREE_COLS];
            end            
            count = count+1;        
        end
        else
        begin
            count = 0;
        end
    end 
    
endmodule
