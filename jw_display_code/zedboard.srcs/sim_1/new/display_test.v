`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2018 07:46:04 PM
// Design Name: 
// Module Name: display_test
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


module display_test(

    );
    
    reg clk;
    reg rst;
    reg [11:0] pixelCol;
    reg [11:0] pixelRow;
    reg vid_en;
    reg [15:0] goodDrops;
    reg [15:0] badDrops;
    wire [3:0] blue;
    wire [3:0] green;
    wire [3:0] red;
    
    display uut(
        .clk(clk),
        .rst(rst),
        .pixelCol(pixelCol),
        .pixelRow(pixelRow),
        .vid_en(vid_en),
        .goodDrops(goodDrops),
        .badDrops(badDrops),
        .blue(blue),
        .green(green),
        .red(red)
    );
    
    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 0;
        pixelCol = 900;
        pixelRow = 100;
        vid_en = 0;
        goodDrops = 0;
        badDrops = 0;
        
        // Wait 100 ns for global reset to finish
        #100;
        
        // Add stimulus here
        
        for (pixelRow = 132; pixelRow < 164; pixelRow = pixelRow + 1) begin
            #10;
            for (pixelCol = 900; pixelCol < 1284; pixelCol = pixelCol +1) begin
                #2;
            end
            
        end

    end
    
    always begin
        #5 clk = !clk;
    end
    
endmodule
