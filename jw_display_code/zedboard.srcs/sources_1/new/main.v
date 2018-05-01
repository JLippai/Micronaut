`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2018 09:32:50 PM
// Design Name: 
// Module Name: main
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


module main(
    // Global Clock
    input      GCLK,
    // LEDs
    output reg LD0,
    // VGA
    output wire [3:0] VGA_BLU,
    output wire [3:0] VGA_GRN,
    output wire [3:0] VGA_RED,
    output wire       VGA_HS,
    output wire       VGA_VS
    );
    
    // Pixel Clock Variables for VGA control
    reg pixel_clk_count = 1'd0;
    reg pixel_clk = 1'b0;
    
    // Divide the Clock to 25 MHz for Pixel Clock
    always @ (posedge(GCLK)) begin
        if (pixel_clk_count) begin
            pixel_clk_count <= 0;
            pixel_clk <= ~pixel_clk;
        end else begin
            pixel_clk_count <= pixel_clk_count + 1;
        end
    end
    
    // Drop Counters
    reg [15:0] goodDrops = 0;
    reg [15:0] badDrops = 0;
    reg [15:0] uglyDrops = 0;
    
    // VGA Related Variables
    wire [11:0] hcnt;
    wire [11:0] vcnt;
    wire vid_en;
    
    // Memory Addressing
    wire [ 12:0] readBlockAddress;
    wire [ 16:0] readByteAddress;
    wire [127:0] pixelBlockOut;
    wire [127:0] pixelOut;
    wire [  2:0] frameSelBlock;
    wire [  2:0] frameSelByte;
    
//    VGA_timing_controller vga(
//        .clk_100MHz_inp(GCLK),
//        .rst_inp(),
//        .hcnt_outp(hcnt),
//        .vcnt_outp(vcnt),
//        .hsync_outp(VGA_HS),
//        .vsync_outp(VGA_VS),
//        .video_active_outp(vid_en)
//    );
    
    vga_controller_640_60 vga (
        .pixel_clk(pixel_clk),
        .HS(VGA_HS),
        .VS(VGA_VS),
        .hcounter(hcnt),
        .vcounter(vcnt),
        .blank(vid_en)
    );
    
    display disp(
        .clk(GCLK),
        .rst(),
        .pixelCol(hcnt),
        .pixelRow(vcnt),
        .blank(vid_en),
        .goodDrops(goodDrops),
        .badDrops(badDrops),
        .uglyDrops(uglyDrops),
        .pixelBlock(pixelOut),
        .frameSel(frameSelByte),
        .pixelAddress(readByteAddress),
        .blue(VGA_BLU),
        .green(VGA_GRN),
        .red(VGA_RED)
    );
    
    Memory mem(
        .clk(GCLK),
        .readAddressProc(readBlockAddress),
        .readAddressVga(readByteAddress),
        .pixelOutProc(pixelBlockOut),
        .pixelOutVga(pixelOut),
        .frameSelVga(frameSelByte)
    );
    
    // Clock Divider Counter
    reg [26:0] counter;
    
    // Toggle LED
    always @ (posedge GCLK) begin
        if (counter == 100000000) begin
            counter <= 0;
            LD0 <= !LD0;
            goodDrops <= goodDrops + 1;
            badDrops <= badDrops + 2;
        end else begin
            counter <= counter + 1'b1;
        end
    end
    
endmodule
