`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2018 10:01:10 PM
// Design Name: 
// Module Name: disp_char
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

`define CHAR_SPACE 0
`define CHAR_COLON 1
`define CHAR_A 2
`define CHAR_B 3
`define CHAR_D 4
`define CHAR_G 5
`define CHAR_O 6
`define CHAR_1 7
`define CHAR_2 8
`define CHAR_3 9
`define CHAR_4 10
`define CHAR_5 11
`define CHAR_6 12
`define CHAR_7 13
`define CHAR_8 14
`define CHAR_9 15
`define CHAR_0 16

module disp_char(
    input  wire [4:0] char_sel,
    input  wire [4:0] char_row,
    input  wire [4:0] char_col,
	output wire       out,

	input  wire       clk,
	input  wire       rst
    );
    
    // 32 bit width
    // 32 bit height
    // 'B' 'A' 'D' 'G' 'O' 'O' 'D' ' ' ':' '1' '2' '3' '4' '5' '6' '7' '8' '9' '0'
    // 17 Possible charaters to be displayed
    reg  [31:0] char_img [(17*32)-1:0];
    
    wire [9:0] char_addr;
    
    assign char_addr = {char_sel, 3'b00000};
    
    initial begin
        $readmemb("char.list", char_img);
    end
    
    
    
endmodule
