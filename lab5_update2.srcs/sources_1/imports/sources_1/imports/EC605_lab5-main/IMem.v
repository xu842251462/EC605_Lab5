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
			memory_file[i] = 32'b000000000001_00000_000_01100_0010011;   // addi x12,x0,1 x12=1
			i = i+1;
			memory_file[i] = 32'b0_000000_01100_00010_001_0010_0_1100011;  // bne x2, x12, exit(pc+4) 12:0_0000_0000_110

			i = i+1;
			memory_file[i] = 32'b000000000100_01100_000_01100_0010011;   // addi x12,x12,4 x12=5
			
			i = i+1;
			memory_file[i] = 32'b000000000100_01100_000_01100_0010011;   // addi x12,x12,4 x12=5
			
			i = i+1;
			memory_file[i] = 32'b000000000100_01100_000_01100_0010011;   // addi x12,x12,4 x12=5
			
			i = i+1;
			memory_file[i] = 32'b000000000100_01100_000_01100_0010011;   // addi x12,x12,4 x12=5

			i = i+1;
			memory_file[i] = 32'b0000000_01101_01100_000_01100_0110011;  // add x12,x12,x13 x12=5

			i = i+1;
			memory_file[i] = 32'b0000000_01101_01100_110_01110_0110011;  // or x14,x12,x13 x14=5

			i = i+1;
			memory_file[i] = 32'b0000000_01100_01100_111_01111_0110011;  // and x15,x12,x12 x15=5 

			i = i+1;
			memory_file[i] = 32'b0000000_10000_01100_010_00100_0100011;  // sw x16, 4(x12)  dmem[9]=x16=0

			i = i+1;
			memory_file[i] = 32'b000000000000_01101_010_00101_0000011;  // lw x5, 0(x13)  x5=dmem[0]

			i = i+1;
			memory_file[i] = 32'b0100000_00100_01100_000_00010_0110011;  // sub x2,x12,x4
			
			i = i+1;
			memory_file[i] = 32'b0_0000000011_0_00000000_00011_1101111;  // jal  imm=6
			// x3 = pc+1; pc=pc+{imm, 1'b0}
			
			i = i+1;
			memory_file[i] = 32'b0100000_01101_00100_000_00010_0110011;  // sub x2,x4,x13


			i = i+1;
			memory_file[i] = 32'b0000000_01100_00010_001_00100_1100011;  // bne x2, x12, exit(pc+4) 12:0_0000_0000_110
            
            i = i+1;
			memory_file[i] = 32'b000000000011_00000_000_01100_0010011;   // addi x12,x0,3

			i = i+1;
			memory_file[i] = 32'b000000000100_01100_000_01100_0010011;   // addi x12,x12,4 
			
			i = i+1;
			memory_file[i] = 32'b000000000001_00000_000_01100_0010011;   // addi x12,x0,1

			i = i+1;
			memory_file[i] = 32'b000000000100_01100_000_01100_0010011;   // addi x12,x12,4 
			
			i = i+1;
			memory_file[i] = 32'b0100000_01101_00100_000_00010_0110011;  // sub x2,x4,x13
			
			i = i+1;
			memory_file[i] = 32'b0100000_01101_00100_000_00010_0110011;  // sub x2,x4,x13
			
			i = i+1;
			memory_file[i] = 32'b000000000000_00011_000_00011_0010011;   // addi x3,x3,0

		end
endmodule

