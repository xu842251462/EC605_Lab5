`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2022 04:00:10 PM
// Design Name: 
// Module Name: t_DataMomery
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


module t_DataMomery(

    );
//    parameter BITSIZE = 64;
//    parameter REGSIZE = 64;
//    reg [$clog2(REGSIZE)-1:0] WriteSelect;
//    reg [BITSIZE-1:0] WriteData;
//    reg WriteEnable, ReadEnable;
//    wire [BITSIZE-1:0] ReadData;
//    reg clk, rst;

//    DataMemory uut(
//        ReadEnable, ReadData,
//        WriteData, WriteEnable, WriteSelect, 
//        clk, rst);
     
//     initial begin
//        clk = 0;
//        rst = 0;
//        WriteSelect = 6'd0;
//        WriteData = 64'd0;
//        WriteEnable = 0;
//        ReadEnable = 0;
//     end
        
//     always@(*)
//        #1clk <= ~clk;
        
//     initial begin
        
//        #50ReadEnable <= 0;
//        #5WriteEnable <= 0;
//        #5WriteData <= 64'd0;
//        #5WriteSelect <= 5'b00000;
        
//        #50
//        #50ReadEnable <= 1;
//        #5WriteEnable <= 1;
//        #5WriteData <= 64'd10;
//        #5WriteSelect <= 5'b00001; 
     
//        #50
//        ReadEnable <= 1;
//        #5WriteEnable <= 0;
//        #5WriteData <= 64'd20;
//        #5WriteSelect <= 5'b00010;  
        
        
////        #50
////        ReadEnable <= 0;
////        #5WriteEnable <= 1;
////        #5WriteData <= 64'd30;
////        #5WriteSelect <= 5'b00100;  
     
//        #10 rst=1;
//        #10 rst=0;

//     end
    reg         r_en;
	wire [63:0] r_data;
	
	reg  [63:0] w_addr;
	reg  [63:0] w_data;
	reg         w_en;

	reg clk;
	reg rst;

	DataMemory uut(
		.ReadEnable(r_en),
		.ReadData(r_data),
		.MemoryAddress(w_addr),
		.WriteData(w_data),
		.WriteEnable(w_en),
		.clk(clk),
		.rst(rst)
	);

	initial begin
		rst = 1;
		#10 rst = 0;
	end

	initial begin
		clk = 1;
		forever #5 clk = ~clk;
	end

	initial begin
		r_en <= 0;
		w_addr <= 0;
		w_data <= 0;
		w_en <= 0;
	end

	initial begin
		#10; w_data <= 64'h31aa; w_addr <= 31; w_en <= 1;
		#10; w_data <= 64'h32bb; w_addr <= 32; r_en <= 1;
		#10; w_data <= 64'h33cc; w_addr <= 33;
		#10; w_data <= 64'h34dd; w_addr <= 34;
		#10; w_data <= 64'h35ee; w_addr <= 35;
		#10; w_data <= 64'h36ff; w_addr <= 36;
        #10; r_en <= 1;
		#400 $finish;
	end
endmodule
