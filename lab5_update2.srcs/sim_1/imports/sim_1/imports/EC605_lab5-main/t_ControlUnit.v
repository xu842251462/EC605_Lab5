`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2022 08:32:53 PM
// Design Name: 
// Module Name: t_controlUnit
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


module t_controlUnit(

    );
    reg [31:0] instruction;
    reg rst;
    reg clk;
    wire MemtoReg, RegWrite, MemRead, MemWrite, ALUSrc, Branch;
    wire [3:0]ALUOp;
    
    ControlUnit uut(clk, instruction, rst, ALUOp, MemtoReg, Branch, MemRead, MemWrite, ALUSrc, RegWrite);
    
    initial
    begin
        #10 rst = 0;
        
        #20instruction <= 32'b00000000000000000111011000110011;
        #20instruction <= 32'b00000000101101011110011000110011;
        #20instruction <= 32'b00000000101101011000011001100011;
        #20instruction <= 32'b00000000101101011001011001100011;
        #20instruction <= 32'b01000000101101011000011000110011;
        #20instruction <= 32'b00000000101101011010011000100011;
        #20instruction <= 32'b00000000101101011010011000000011;//lw
        #20instruction <= 32'b00000000101101011000011000110111;//lui
    
        #400 $finish;
    end
endmodule
