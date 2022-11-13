`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2022 03:01:14 PM
// Design Name: 
// Module Name: mem_mux
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


module Mem_mux(
    input [31:0] data,
    input [31:0] immed,
    input flag,
    output reg [31:0] out
);

    always@(data, immed, flag)begin
        if (flag==0)
            out <= data;
        else
            out <=immed;
    end
endmodule
