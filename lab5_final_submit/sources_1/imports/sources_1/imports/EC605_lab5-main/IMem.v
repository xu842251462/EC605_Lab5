`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2022 03:33:15 PM
// Design Name: 
// Module Name: IMem
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

module Instruction_Memory(Address, ReadData1);
	parameter BITSIZE = 32;
	parameter REGSIZE = 32;
	//intruction
	input [REGSIZE-1:0] Address;
	output reg [BITSIZE-1:0] ReadData1;

	reg [BITSIZE-1:0] memory_file [0:REGSIZE-1];	// Entire list of memory
    
	// Asyncronous read of memory. Was not specified.
	always @(Address, memory_file[Address])
        begin
            ReadData1 = memory_file[Address];
        end
        
    initial
    begin
        memory_file[0] = 32'b0; // initialize x0 as 0;
    end
    
	integer i;
	// method of filling the memory instead of through a test bench
	initial
		begin
			i = 0;
			
			i = i+1;
			memory_file[i] = 32'b000000000000_00000_111_01100_0110011;//and

			i = i+1;
			memory_file[i] = 32'b000000011111_01101_000_01101_0110011;//add

			i = i+1;
			memory_file[i] = 32'b000000001011_01011_110_01100_0110011;//or
			
			i = i+1;
			memory_file[i] = 32'b0000000_01011_01011_000_01100_1100011;//beq
			
			i = i+1;
			memory_file[i] = 32'b0000000_01011_01011_001_01100_1100011;//bne
			
			i = i+1;
			memory_file[i] = 32'b010000001011_01011_000_01100_0110011;//sub
			
			i = i+1;
			memory_file[i] = 32'b0000000_01011_01011_010_01100_0100011;//sw
			
			i = i+1;
			memory_file[i] = 32'b0000000_01011_01011_010_01100_0000011;//lw
			
			i = i+1;
			memory_file[i] = 32'b0000000_01011_01011_000_01100_0110111;//lui
			
			i = i+1;
			memory_file[i] = 32'b0000000_01011_01011_000_01100_0010011;//addi

		end
endmodule

