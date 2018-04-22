`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2018 09:37:40 PM
// Design Name: 
// Module Name: display
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


module display(
        input  wire        clk,
        input  wire        rst,
        input  wire [11:0] pixelCol,
        input  wire [11:0] pixelRow,
        input  wire        vid_en,
        input  wire [15:0] goodDrops,
        input  wire [15:0] badDrops,
        output wire  [3:0] blue,
        output wire  [3:0] green,
        output wire  [3:0] red
    );
    
    parameter FONT_WIDTH = 32;
    parameter FONT_HEIGHT = 32;
    parameter FRAME_WIDTH = 320;
    parameter FRAME_HEIGHT = 240;
    parameter VID_X_POS = 100;
    parameter VID_Y_POS = 100;
    parameter LOGO_X_POS = 600;
    parameter LOGO_Y_POS = 700;
    parameter TEXT_X_POS = 900;
    parameter TEXT_Y_POS = 100;
    
    reg [4:0] text_grid;
    reg [4:0] char_sel;
    reg [4:0] char_row;
    reg [4:0] char_col;
    wire pixelEn;
    reg vidFrameEn;
    reg logoEn;
    wire textEn;
    
    disp_char charDisp(
        .clk(clk),
        .rst(rst),
        .char_sel(char_sel),
        .char_row(char_row),
        .char_col(char_col),
        .out(textEn)
    );
    
    // Calculations for which Pixels to turn on
    always @ (*) begin
        // Video Frame from camera
        vidFrameEn <= (pixelRow >=VID_Y_POS && pixelRow < (VID_Y_POS + FRAME_HEIGHT) && pixelCol >= VID_X_POS && pixelCol < (VID_X_POS + FRAME_WIDTH)) ? 1'b1 : 1'b0;
        
        // CIDAR LOGO
        logoEn <= (pixelRow >=LOGO_Y_POS && pixelRow < (LOGO_Y_POS + FRAME_HEIGHT) && pixelCol >= LOGO_X_POS && pixelCol < (LOGO_X_POS + FRAME_WIDTH)) ? 1'b1 : 1'b0;
        
        // Test Area for Good and Bad droplet reporting
        if (pixelRow >= TEXT_Y_POS && pixelRow < (TEXT_Y_POS + (FONT_HEIGHT * 2)) &&
            pixelCol >= TEXT_X_POS && pixelCol < (TEXT_X_POS + (FONT_WIDTH * 12))) begin
            // Calculate which text position
            if (pixelRow >= (TEXT_Y_POS + FONT_HEIGHT)) text_grid <= { ((pixelCol - TEXT_X_POS) % FONT_WIDTH), 1'b0};
            else text_grid <= ((pixelCol - TEXT_X_POS) % FONT_WIDTH);
            
            case (text_grid)
                0 : char_sel = `CHAR_G;
                1 : char_sel = `CHAR_O;
                2 : char_sel = `CHAR_O;
                3 : char_sel = `CHAR_D;
                4 : char_sel = `CHAR_SPACE;
                5 : char_sel = `CHAR_COLON;
                6 : char_sel = `CHAR_SPACE;
//                7 : char_sel =  number;
//                8 : char_sel =  number;
//                9 : char_sel =  number;
//                10: char_sel =  number;
//                11: char_sel =  number;
                12: char_sel = `CHAR_SPACE;
                13: char_sel = `CHAR_B;
                14: char_sel = `CHAR_A;
                15: char_sel = `CHAR_D;
                16: char_sel = `CHAR_SPACE;
                17: char_sel = `CHAR_COLON;
                18: char_sel = `CHAR_SPACE;
//                19: char_sel =  number;
//                20: char_sel =  number;
//                21: char_sel =  number;
//                22: char_sel =  number;
//                23: char_sel =  number;
                default: char_sel = `CHAR_SPACE;
            endcase
            
            char_col <= ((pixelCol - TEXT_X_POS) % FONT_WIDTH);
            char_row <= ((pixelRow - TEXT_Y_POS) % FONT_HEIGHT);
        end
    end
    
    assign red = vid_en ? (vidFrameEn ? 4'b1111 : (logoEn ? 4'b1111 : (textEn ? 4'b1111 : 4'b0000))) : 4'b0000;
    assign green = vid_en ? (vidFrameEn ? 4'b1010 : (logoEn ? 4'b1111 : (textEn ? 4'b1111 : 4'b0000))) : 4'b0000;
    assign blue = vid_en ? (vidFrameEn ? 4'b1111 : (logoEn ? 4'b1010 : (textEn ? 4'b1111 : 4'b0000))) : 4'b0000;
    
endmodule
