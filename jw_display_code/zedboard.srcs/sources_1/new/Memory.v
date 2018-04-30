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
    input    [2:0] frameSelProc,
    input   [12:0] readAddressProc,
    input    [2:0] frameSelVga,
    input   [16:0] readAddressVga,
    output [127:0] pixelOutProc,
    output [127:0] pixelOutVga,
    input   [12:0] writeAddress,
    input  [127:0] pixelIn,
    input          writeEn
    );
    
    wire [127:0] frame0PixelProc;
    wire [127:0] frame0PixelVga;
    wire [127:0] frame1PixelProc;
    wire [127:0] frame1PixelVga;
    wire [127:0] frame2PixelProc;
    wire [127:0] frame2PixelVga;
    wire [127:0] refFramePixelProc;
    wire [127:0] refFramePixelVga;
    wire [127:0] outFramePixelProc;
    wire [127:0] outFramePixelVga;
    
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
      
      blk_mem_logo frame0 (
        .clka(clk),
        .ena(1),
        .wea(0),
        .addra(readAddressProc),
        .dina(0),
        .douta(frame0PixelProc),
        .clkb(clk),
        .enb(1),
        .web(0),
        .addrb(readAddressVga),
        .dinb(0),
        .doutb(frame0PixelVga)
      ); 
        
//      blk_mem_gen_1 frame1 (
//      blk_mem_logo frame1 (
      blk_mem_gen_0 frame1 (
        .clka(clk),
        .ena(1),
        .wea(0),
        .addra(readAddressProc),
        .dina(0),
        .douta(frame1PixelProc),
        .clkb(clk),
        .enb(1),
        .web(0),
        .addrb(readAddressVga),
        .dinb(0),
        .doutb(frame1PixelVga)
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
    
//    assign pixelBlockOut = (frameSelBlock == 0) ? frame0PixelBlock :
//                           ((frameSelBlock == 1) ? frame1PixelBlock :
//                           ((frameSelBlock == 2) ? frame2PixelBlock :
//                           ((frameSelBlock == 3) ? refFramePixelBlock :
//                           ((frameSelBlock == 4) ? outFramePixelBlock : refFramePixelBlock))));
                           
    assign pixelOutVga = (frameSelVga == 0) ? frame0PixelVga :
                         ((frameSelVga == 1) ? frame1PixelVga :
                         ((frameSelVga == 2) ? frame2PixelVga :
                         ((frameSelVga == 3) ? refFramePixelVga :
                         ((frameSelVga == 4) ? outFramePixelVga : refFramePixelVga))));
//    always @ (*) begin
//        case(frameSelByte)
//            0: pixelOut <= frame0Pixel;
//            1: pixelOut <= frame1Pixel;
//            2: pixelOut <= frame2Pixel;
//            3: pixelOut <= refFramePixel;
//            4: pixelOut <= outFramePixel;
//            default: pixelOut <= refFramePixel;
//        endcase
//    end
    
endmodule
