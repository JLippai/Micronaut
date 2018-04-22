`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2018 02:49:44 PM
// Design Name: 
// Module Name: main_test
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


module main_test(

    );
    
    reg GCLK;
    // LEDs
    wire LD0;
    // VGA
    wire VGA_B1;
    wire VGA_B2;
    wire VGA_B3;
    wire VGA_B4;
    wire VGA_G1;
    wire VGA_G2;
    wire VGA_G3;
    wire VGA_G4;
    wire VGA_R1;
    wire VGA_R2;
    wire VGA_R3;
    wire VGA_R4;
    wire VGA_HS;
    wire VGA_VS;
    
    main uut (
        .GCLK(GCLK),
        .LD0(LD0),
        .VGA_B1(VGA_B1),
        .VGA_B2(VGA_B2),
        .VGA_B3(VGA_B3),
        .VGA_B4(VGA_B4),
        .VGA_G1(VGA_G1),
        .VGA_G2(VGA_G2),
        .VGA_G3(VGA_G3),
        .VGA_G4(VGA_G4),
        .VGA_R1(VGA_R1),
        .VGA_R2(VGA_R2),
        .VGA_R3(VGA_R3),
        .VGA_R4(VGA_R4),
        .VGA_HS(VGA_HS),
        .VGA_VS(VGA_VS)
    );
    
    initial begin
        // Initialize Inputs
        GCLK = 0;

        // Wait 100 ns for global reset to finish
        #100;
        
        // Add stimulus here

    end
    
    always begin
        #5 GCLK = !GCLK;
    end
    
endmodule
