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

module Memory(
    input          clk,
    input    [2:0] frameSelBlock,
    input   [12:0] readBlockAddress,
    input    [2:0] frameSelByte,
    input   [16:0] readByteAddress,
    output [127:0] pixelBlockOut,
//    output   [7:0] pixelOut,
    output [127:0] pixelOut,
    input   [12:0] writeBlockAddress,
    input  [127:0] pixelBlockIn,
    input          writeEn
    );
    
    wire [127:0] frame0PixelBlock;
    wire [127:0] frame0Pixel;
    wire [127:0] frame1PixelBlock;
    wire [127:0] frame1Pixel;
    wire [127:0] frame2PixelBlock;
    wire [127:0] frame2Pixel;
    wire [127:0] refFramePixelBlock;
    wire [127:0] refFramePixel;
    wire [127:0] outFramePixelBlock;
    wire [127:0] outFramePixel;
    
//    frameMem #("redcrossing.list") frame0 (
//    //frameMem frame0 (
//        .clk(clk),
//        .blockAddress(readBlockAddress),
//        .readByteAddress(readByteAddress),
//        .pixBlock(frame0PixelBlock),
//        .pixelOut(frame0Pixel),
//        .pixelBlockIn(0),
//        .writeEn(0)
//        );
      
      blk_mem_gen_0 frame0 (
        .clka(clk),
        .ena(1),
        .wea(0),
        .addra(readBlockAddress),
        .dina(0),
        .douta(frame0PixelBlock),
        .clkb(clk),
        .enb(1),
        .web(0),
        .addrb(readByteAddress),
        .dinb(0),
        .doutb(frame0Pixel)
      ); 
        
      blk_mem_gen_1 frame1 (
        .clka(clk),
        .ena(1),
        .wea(0),
        .addra(readBlockAddress),
        .dina(0),
        .douta(frame1PixelBlock),
        .clkb(clk),
        .enb(1),
        .web(0),
        .addrb(readByteAddress),
        .dinb(0),
        .doutb(frame1Pixel)
      );  
        
//    frameRam #(.INIT_FILE("redcrossing2.list")) frame (
////    frameRam frame (
//        .clk(clk),
//        .we(0),
//        .a(readBlockAddress),
//        .dpra(readByteAddress),
//        .di(0),
//        .spo(pixelBlockOut),
//        .dpo(pixelOut)
//        );
        
//    frameMem #("bluenocrossing.list") frame1(
//            .readBlockAddress(readBlockAddress),
//            .readByteAddress(readByteAddress),
//            .pixBlock(frame1PixelBlock),
//            .pixelOut(frame1Pixel),
//            .writeBlockAddress(),
//            .pixelBlockIn(),
//            .writeEn()
//            );
            
//    frameMem  #("bluecrossing.list") frame2(
//            .readBlockAddress(readBlockAddress),
//            .readByteAddress(readByteAddress),
//            .pixBlock(frame2PixelBlock),
//            .pixelOut(frame2Pixel),
//            .writeBlockAddress(),
//            .pixelBlockIn(),
//            .writeEn()
//            );
            
//    frameMem #("logo-Cidar-Color320_240.list") refFrame(
//            .readBlockAddress(readBlockAddress),
//            .readByteAddress(readByteAddress),
//            .pixBlock(refFramePixelBlock),
//            .pixelOut(refFramePixel),
//            .writeBlockAddress(),
//            .pixelBlockIn(),
//            .writeEn()
//            );
            
//    frameMem #("logo-Cidar-Color320_240.list") outFrame(
//            .readBlockAddress(readBlockAddress),
//            .readByteAddress(readByteAddress),
//            .pixBlock(outFramePixelBlock),
//            .pixelOut(outFramePixel),
//            .writeBlockAddress(writeBlockAddress),
//            .pixelBlockIn(pixelBlockIn),
//            .writeEn(writeEn)
//            );
    
    assign pixelBlockOut = (frameSelBlock == 0) ? frame0PixelBlock :
                           ((frameSelBlock == 1) ? frame1PixelBlock :
                           ((frameSelBlock == 2) ? frame2PixelBlock :
                           ((frameSelBlock == 3) ? refFramePixelBlock :
                           ((frameSelBlock == 4) ? outFramePixelBlock : refFramePixelBlock))));
                           
    assign pixelOut = (frameSelByte == 0) ? frame0Pixel :
                      ((frameSelByte == 1) ? frame1Pixel :
                      ((frameSelByte == 2) ? frame2Pixel :
                      ((frameSelByte == 3) ? refFramePixel :
                      ((frameSelByte == 4) ? outFramePixel : refFramePixel))));
    
    
endmodule
