
`timescale 1ns / 1ns

`define OP_AND   4'b0000
`define OP_OR    4'b0001
`define OP_ADD   4'b0010
`define OP_SUB   4'b0110
`define OP_SLT   4'b0111
`define OP_NOR   4'b1100
`define OP_ADDI  4'b0011

module t_alu();
	reg [31:0] a;
	reg [31:0] b;
	reg [3:0] op;

	wire [31:0] out;
    wire zero;
	reg clk;
	reg rst;
	
	Alu uut(
		.a_data(a),
		.b_data(b),
		.alu_op(op),
		.out(out),
		.clk(clk),
		.rst(rst),
		.zero(zero)
	);

	initial begin
		clk = 1;
		forever #5 clk = ~clk;
	end

	initial begin
		rst = 1;
		#10 rst = 0;
	end

	initial begin
		a <= 0;
		b <= 0;
		op <= 0;
	end

	initial begin
		
		#10;
		a <= 7; b <= 5; op <= `OP_AND;
		#10; op <= `OP_ADD;
		#10; op <= `OP_SUB;
		#10; op <= `OP_SLT;
		#10; op <= `OP_OR;
		#10; op <= `OP_NOR;
		#10; a <= 5; b <= 7;
	
		#30; $finish;
	end

endmodule