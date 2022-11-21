`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2022 04:01:38 PM
// Design Name: 
// Module Name: pc_counter
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


module pc_counter(
    input clk,
    input rst,
    input zero_flag,
    input jumpIn,
    input branch,
    input [31:0] imm,
    input [6:0] opcode,
    output reg [31:0] pc
);

    always @ (posedge clk) begin
        if (rst) begin
            pc <= 32'h0;
        end
        // add jump instructions
        else if ((branch == 1 && zero_flag == 1) || jumpIn==1) begin
            pc <= pc + $signed(imm);
        end
        else
            pc <= pc + 1'b1;
    end
endmodule
