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
        input  wire [15:0] uglyDrops,
        input  wire  [7:0] frPixel,
        input  wire  [7:0] logoPixel,
        output reg  [16:0] frPixAddress,
        output reg  [16:0] logoPixAddress,
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
    
    // Frame Variables
    reg [3:0] pixelBlue;
    reg [3:0] pixelGreen;
    reg [3:0] pixelRed;
    
    // Counter Text Area Variables
    reg [5:0] text_grid;
    reg [4:0] char_sel;
    reg [4:0] char_row;
    reg [4:0] char_col;
    wire pixelEn;
    reg vidFrameEn;
    reg logoEn;
    reg textEn;
    
    disp_char charDisp(
        .clk(clk),
        .rst(rst),
        .char_sel(char_sel),
        .char_row(char_row),
        .char_col(char_col),
        .out(pixelEn)
    );
    
    // Calculations for which Pixels to turn on
    always @ (*) begin
        // Video Frame from camera
        if (pixelRow >=VID_Y_POS && pixelRow < (VID_Y_POS + FRAME_HEIGHT) &&
            pixelCol >= VID_X_POS && pixelCol < (VID_X_POS + FRAME_WIDTH)) begin
            vidFrameEn <= 1'b1;
            frPixAddress <= (pixelCol - LOGO_X_POS) + ((pixelRow - LOGO_Y_POS) * FRAME_WIDTH);
            pixelBlue <= frPixel[1:0] << 2;  // Scale by 4 to convert 2 bit to 4 bit color
            pixelGreen <= frPixel[4:2] << 1; // Scale by 2 to convert 3 bit to 4 bit color
            pixelRed <= frPixel[7:5] << 1;   // Scale by 2 to convert 3 bit to 4 bit color
        end else begin
            vidFrameEn <= 1'b0;
            frPixAddress <= 17'd0;
        end
        
        // CIDAR LOGO
        if (pixelRow >=LOGO_Y_POS && pixelRow < (LOGO_Y_POS + FRAME_HEIGHT) &&
            pixelCol >= LOGO_X_POS && pixelCol < (LOGO_X_POS + FRAME_WIDTH)) begin
            logoEn <= 1'b1;
            logoPixAddress <= (pixelCol - LOGO_X_POS) + ((pixelRow - LOGO_Y_POS) * FRAME_WIDTH);
            pixelBlue <= logoPixel[1:0] << 2;  // Scale by 4 to convert 2 bit to 4 bit color
            pixelGreen <= logoPixel[4:2] << 1; // Scale by 2 to convert 3 bit to 4 bit color
            pixelRed <= logoPixel[7:5] << 1;   // Scale by 2 to convert 3 bit to 4 bit color
        end else begin
            logoEn <= 1'b0;
            logoPixAddress <= 17'd0;
        end
        
        // Test Area for Good and Bad droplet reporting
        if (pixelRow >= TEXT_Y_POS && pixelRow < (TEXT_Y_POS + (FONT_HEIGHT * 3)) &&
            pixelCol >= TEXT_X_POS && pixelCol < (TEXT_X_POS + (FONT_WIDTH * 12))) begin
            textEn <= 1'b1;  // In the Text Block
            // Calculate which text position
            if (pixelRow >= (TEXT_Y_POS + (2 * FONT_HEIGHT))) text_grid <= ((pixelCol - TEXT_X_POS) / FONT_WIDTH) + 24;
            else if (pixelRow >= (TEXT_Y_POS + FONT_HEIGHT)) text_grid <= ((pixelCol - TEXT_X_POS) / FONT_WIDTH) + 12;
            else text_grid <= ((pixelCol - TEXT_X_POS) / FONT_WIDTH);
            
            case (text_grid)
                0 : char_sel = `CHAR_G;
                1 : char_sel = `CHAR_O;
                2 : char_sel = `CHAR_O;
                3 : char_sel = `CHAR_D;
                4 : char_sel = `CHAR_SPACE;
                5 : char_sel = `CHAR_COLON;
                6 : char_sel = `CHAR_SPACE;
                7 : char_sel =  (goodDrops >= 10000) ? goodDrops / 10000 : `CHAR_SPACE;
                8 : char_sel =  (goodDrops >= 1000) ? (goodDrops % 10000) / 1000 : `CHAR_SPACE;
                9 : char_sel =  (goodDrops >= 100) ? (goodDrops % 1000) / 100 : `CHAR_SPACE;
                10: char_sel =  (goodDrops >= 10) ? (goodDrops % 100) / 10 : `CHAR_SPACE;
                11: char_sel =  goodDrops % 10;
                12: char_sel = `CHAR_SPACE;
                13: char_sel = `CHAR_B;
                14: char_sel = `CHAR_A;
                15: char_sel = `CHAR_D;
                16: char_sel = `CHAR_SPACE;
                17: char_sel = `CHAR_COLON;
                18: char_sel = `CHAR_SPACE;
                19: char_sel =  (badDrops >= 10000) ? badDrops / 10000 : `CHAR_SPACE;
                20: char_sel =  (badDrops >= 1000) ? (badDrops % 10000) / 1000 : `CHAR_SPACE;
                21: char_sel =  (badDrops >= 100) ? (badDrops % 1000) / 100 : `CHAR_SPACE;
                22: char_sel =  (badDrops >= 10) ? (badDrops % 100) / 10 : `CHAR_SPACE;
                23: char_sel =  badDrops % 10;
                24: char_sel = `CHAR_U;
                25: char_sel = `CHAR_G;
                26: char_sel = `CHAR_L;
                27: char_sel = `CHAR_Y;
                28: char_sel = `CHAR_SPACE;
                29: char_sel = `CHAR_COLON;
                30: char_sel = `CHAR_SPACE;
                31: char_sel =  (uglyDrops >= 10000) ? uglyDrops / 10000 : `CHAR_SPACE;
                32: char_sel =  (uglyDrops >= 1000) ? (uglyDrops % 10000) / 1000 : `CHAR_SPACE;
                33: char_sel =  (uglyDrops >= 100) ? (uglyDrops % 1000) / 100 : `CHAR_SPACE;
                34: char_sel =  (uglyDrops >= 10) ? (uglyDrops % 100) / 10 : `CHAR_SPACE;
                35: char_sel =  uglyDrops % 10;
                default: char_sel = `CHAR_SPACE;
            endcase
            
            char_col <= ((pixelCol - TEXT_X_POS) % FONT_WIDTH);
            char_row <= ((pixelRow - TEXT_Y_POS) % FONT_HEIGHT);
        end else textEn <= 1'b0;  // Not In the Text Block
    end
    
    assign red = vid_en ? (vidFrameEn || logoEn) ? pixelRed : ((textEn && pixelEn) ? 4'b1111 : 4'b0000) : 4'b0000;
    assign green = vid_en ? (vidFrameEn || logoEn) ? pixelGreen : ((textEn && pixelEn) ? 4'b1111 : 4'b0000) : 4'b0000;
    assign blue = vid_en ? (vidFrameEn || logoEn) ? pixelBlue : ((textEn && pixelEn) ? 4'b1111 : 4'b0000) : 4'b0000;
    
endmodule
