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
    input    [2:0] frameSelBlock,
    input   [12:0] readBlockAddress,
    input    [2:0] frameSelByte,
    input   [16:0] readByteAddress,
    output [127:0] pixelBlockOut,
    output   [7:0] pixelOut,
    input   [12:0] writeBlockAddress,
    input  [127:0] pixelBlockIn,
    input          writeEn
    );
    
    wire frame0PixelBlock;
    wire frame0Pixel;
    wire frame1PixelBlock;
    wire frame1Pixel;
    wire frame2PixelBlock;
    wire frame2Pixel;
    wire refFramePixelBlock;
    wire refFramePixel;
    wire outFramePixelBlock;
    wire outFramePixel;
    
    frameMem frame0(
        .readBlockAddress(readBlockAddress),
        .readByteAddress(readByteAddress),
        .pixBlock(frame0PixelBlock),
        .pixelOut(frame0Pixel),
        .writeBlockAddress(),
        .pixelBlockIn(),
        .writeEn()
        );
        
    frameMem frame1(
            .readBlockAddress(readBlockAddress),
            .readByteAddress(readByteAddress),
            .pixBlock(frame1PixelBlock),
            .pixelOut(frame1Pixel),
            .writeBlockAddress(),
            .pixelBlockIn(),
            .writeEn()
            );
            
    frameMem frame2(
            .readBlockAddress(readBlockAddress),
            .readByteAddress(readByteAddress),
            .pixBlock(frame2PixelBlock),
            .pixelOut(frame2Pixel),
            .writeBlockAddress(),
            .pixelBlockIn(),
            .writeEn()
            );
            
    frameMem refFrame(
            .readBlockAddress(readBlockAddress),
            .readByteAddress(readByteAddress),
            .pixBlock(refFramePixelBlock),
            .pixelOut(refFramePixel),
            .writeBlockAddress(),
            .pixelBlockIn(),
            .writeEn()
            );
            
    frameMem outFrame(
            .readBlockAddress(readBlockAddress),
            .readByteAddress(readByteAddress),
            .pixBlock(outFramePixelBlock),
            .pixelOut(outFramePixel),
            .writeBlockAddress(writeBlockAddress),
            .pixelBlockIn(pixelBlockIn),
            .writeEn(writeEn)
            );
    
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
