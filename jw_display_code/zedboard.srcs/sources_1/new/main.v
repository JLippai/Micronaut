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
    wire [ 12:0] readAddressProc;
    wire [ 12:0] readAddressVga;
    wire [ 12:0] readAddressRef;
    wire [127:0] pixelOutProc;
    wire [127:0] pixelOutVga;
    wire [127:0] pixelOutRef;
    wire [  2:0] frameSelProc;
    wire [  2:0] frameSelVga;
    reg  [ 12:0] writeAddress;
    reg  [127:0] pixelIn;
    reg          writeEn;
    
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
        .pixelBlock(pixelOutVga),
        .frameSel(frameSelVga),
        .pixelAddress(readAddressVga),
        .blue(VGA_BLU),
        .green(VGA_GRN),
        .red(VGA_RED)
    );
    
    Memory mem(
        .clk(GCLK),
        .readAddressProc(readAddressProc),
        .readAddressVga(readAddressVga),
        .readAddressRef(readAddressRef),
        .pixelOutProc(pixelOutProc),
        .pixelOutVga(pixelOutVga),
        .pixelOutRef(pixelOutRef),
        .frameSelProc(frameSelProc),
        .frameSelVga(frameSelVga),
        .writeAddress(writeAddress),
        .pixelIn(pixelIn),
        .writeEn(writeEn)
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
    
    // Write to mem test
    reg [1:0] state = 0;
    always @ (posedge GCLK) begin
        case (state)
        // Calculate write address
        0: begin
            // Left Frame display
            if (vcnt >= 0 && vcnt < (0 + 240) &&
                hcnt >= 320 && hcnt < (320 + 320)) begin
                
                // Index into pixel memory
                writeAddress = ((hcnt - 320) + ((vcnt - 0) * 320)) >> 4;    //equivalent to division by 16
                pixelIn = 128'd0;
            end
            else writeAddress = 1;
            
            state = 1;
            
          end
        
        // write to memory?  
        1: begin
               if (writeAddress % 20 == 0) writeEn = 1;
               state = 2;
           end
          
        // Reset Write En
        2: begin
               writeEn = 0;
               state = 0;
           end
          
       endcase
    end
    
endmodule
