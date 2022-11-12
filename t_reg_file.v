`timescale 1ns / 1ns


module t_registerfile();
	wire [31:0] a_data, b_data;
	reg  [31:0] a_sel,  b_sel;

	reg  [31:0] w_data;
	reg  [31:0] w_sel;
	reg         w_en;
     
	reg clk, rst;
    
	Register_File uut(
		.ReadData1(a_data),
		.ReadSelect1 (a_sel),
		
		.ReadData2(b_data),
		.ReadSelect2(b_sel),

		.WriteData(w_data),
		.address (w_sel),
		.WriteEnable  (w_en),
           
		.clk(clk),
		.rst(rst)
	);

	initial begin
		rst = 1;
		#10 rst = 0;
		#990 $finish;
	end

	initial begin
		clk = 1;
		forever #5 clk = ~clk;
	end

	initial begin
		a_sel  <= 0;
		b_sel  <= 0;
		w_sel  <= 0;
		w_data <= 0;
		w_en   <= 0;
	end

	initial begin

		#10;
		w_data <= 32'hf000; w_en <= 1; w_sel <= 1;
		a_sel <= 1;
		#10; 
		w_data <= 32'hfbbb; w_en <= 0; w_sel <= 1;
		b_sel <= 3;
		#10; 
		w_data <= 32'h5678; w_en <= 1; w_sel <= 5;
		#10; 
		w_data <= 32'h4567; w_en <= 1; w_sel <= 4;
		#10; 
		w_data <= 32'h3456; w_en <= 1; w_sel <= 3;
		#10; 
		w_data <= 32'h2345; w_en <= 1; w_sel <= 2;
		#10; 
		w_data <= 32'h1234; w_en <= 1; w_sel <= 1;
		#10; 
		w_data <= 32'h0123; w_en <= 1; w_sel <= 0;
		#10; 
		w_en <= 0;
		a_sel <= 0;
		b_sel <= 1;
		#10;
		a_sel <= 2;
		b_sel <= 3;
		#10;
		a_sel <= 4;
		b_sel <= 5;
		#10;
		a_sel <= 6;
		b_sel <= 7;
	end
endmodule
