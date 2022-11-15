`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2022 03:54:30 PM
// Design Name: 
// Module Name: DataMemory
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


module DataMemory(ReadData, ReadEnable, WriteData, WriteEnable, Address, clk, rst);

    parameter BITSIZE = 64;
    parameter REGSIZE = 64;
    input [$clog2(REGSIZE)-1:0] Address;
    input [BITSIZE-1:0] WriteData;
    input WriteEnable, ReadEnable;
    output reg [BITSIZE-1:0] ReadData;
    input clk, rst;

    reg [BITSIZE-1:0] data_mem_file [REGSIZE-1:0];   // Entire list of registers
    initial
    begin
        data_mem_file[0] = 64'b0; // initialize x0 as 0;
    end
    integer i;                                  // Used below to rst all registers

    // Asyncronous read of register file.
    always @(*)
        begin
            if (ReadEnable && Address != 63)
                ReadData = data_mem_file[Address];
        end

    // Write back to register file on clk edge.
    always @(posedge clk)
        begin
            if (rst)
                for (i=0; i<REGSIZE; i=i+1) data_mem_file[i] <= 32'b0; // rst all registers
            else
            begin
                if (WriteEnable && Address != 0)
                    data_mem_file[Address] <= WriteData; //If writeback is enabled and not register0.
            end
        end
endmodule