`timescale 1ns / 1ns

`define OP_AND   4'b0000
`define OP_OR    4'b0001
`define OP_ADD   4'b0010
`define OP_SUB   4'b0011
`define OP_SLT   4'b0100
`define OP_NOR   4'b0101
`define OP_ADDI  4'b0110

module Alu(
	input wire [31:0] a_data,
	input wire [31:0] b_data,

	input wire [3:0] alu_op,

	output reg [31:0] out,
    output reg zero, //flag
    
    
	input wire clk,
	input wire rst
);
	
	wire signed [31:0] signed_a;
	wire signed [31:0] signed_b;

	assign signed_a = a_data;
	assign signed_b = b_data;
	
	always @(*) begin
		#1;
		case (alu_op)
			`OP_AND:   out = a_data & b_data;
			`OP_OR:    out = a_data | b_data;
			`OP_ADD:   out = a_data + b_data;
			`OP_SUB:   out = a_data - b_data;
			`OP_SLT:   out = a_data < b_data;
			`OP_NOR:   out = ~(a_data | b_data);
			`OP_ADDI:  out = a_data + 1;
			 default:  out = 32'b0;
		endcase
		
		if (out == 32'b0) begin 
            zero <= 1'b1;
        end else begin
            zero <= 1'b0;
        end
	end
endmodule


