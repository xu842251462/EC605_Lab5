`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2022 06:13:46 PM
// Design Name: 
// Module Name: t_IMem
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


module t_IMem(

    );
    parameter BITSIZE = 32;
	parameter REGSIZE = 32;
	//intruction
	reg [REGSIZE-1:0] Address;
	wire [BITSIZE-1:0] ReadData1;

    Instruction_Memory uut(Address, ReadData1);
    
    initial
    begin
        #10Address = 32'b0;
        #10Address = 32'b1;
        #10Address = 32'b110;
        #10Address = 32'b10;
        #14Address = 32'b1010;
        
        #400 $finish;
    end
endmodule
