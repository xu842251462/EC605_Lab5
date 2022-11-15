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
    input branch,
    input [31:0] extended,
    input [6:0] opcode,
    output reg [31:0] pc
);

    always @ (posedge clk) begin
        if (rst) begin
            pc <= 32'h0;
        end
        // add jump instructions
//        else if ((opcode == 7'b1100011 || opcode == 7'b1101111) && (!zero_flag) )  begin
        else if (branch == 1 && !zero_flag )  begin
            pc <= pc + extended;
        end
        else
            pc <= pc + 1'b1;
    end
endmodule
