`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2022 09:10:07 PM
// Design Name: 
// Module Name: top
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


module top(
       input clk,
       input rst,
       output  [31:0] Tins,//instruction
       output  [31:0] Tins_Addr,//Instructions Address
    
       output  [31:0] TmemReadData,//Read data from memory
       output  [31:0] TmemAddr,// Data memory Address 
       output  [31:0] TmemWriteData,// Data wrote to data memory
       output   TMemWrite, // control signal
       output   TMemRead, // control signal
    
       output  [31:0] TrReadData1, 
       output  [31:0] TrReadData2,
       output  [4:0] TrReadSelect1, 
       output  [4:0] TrReadSelect2, 
       output  [4:0] TrWriteSelect, 
       output  [31:0] TrWriteData, // Data wrote to Register file
       output  TrWriteEnable// Control singal for Reginster file
       
    );
    
     //ports for IMEM
    wire [31:0] ins;//instruction
    wire [31:0] ins_Addr;//Instructions Address
    
    Instruction_Memory im(
        .Address(pc),
	    .ReadData1(ins)
    );
    
    //ports for Data Memory
    wire [31:0] memReadData;//Read data from memory
    wire [31:0] memAddr;// Data memory Address 
    wire [31:0] memWriteData;// Data wrote to data memory
    wire  MemWrite; // control signal
    wire  MemRead; // control signal
    
    DataMemory dm(
        .Address(memAddr),
        .ReadData(memReadData),
        .ReadEnable(MemRead),
        .WriteData(memWriteData),
        .WriteEnable(MemWrite),
        .clk(clk),
        .rst(rst)
    );
    
    //ports for Register file
    //control singal for Reginster file
    wire [31:0] rReadData1; 
    wire [31:0] rReadData2;
    wire [4:0] rReadSelect1; 
    wire [4:0] rReadSelect2; 
    wire [4:0] rWriteSelect; 
    wire [31:0] rWriteData; // Data wrote to Register file
    wire rWriteEnable;// Control singal for Reginster file
    
    Register_File rf(
        .ReadSelect1(rReadSelect1),
        .ReadSelect2(rReadSelect2),
        .address(rWriteSelect),
        .WriteData(rWriteData),
        .WriteEnable(rWriteEnable),
        .ReadData1(rReadData1),
        .ReadData2(rReadData2),       
        .clk(clk),
        .rst(rst)
    );
    
    Datapath datapath(
    clk, 
    rst, 
    pc, 
    instruction,
    alu_output,data_2,mem_out,mem_write,mem_read,
    read_data_1,read_data_2,write_select,write_data,reg_write,data_1,data_2);
    
       assign  Tins = ins;//instruction
       assign  Tins_Addr = ins_Addr;//Instructions Address

       assign  TmemReadData = memReadData;//Read data from memory
       assign  TmemAddr = memAddr; // Data memory Address 
       assign  TmemWriteData = memWriteData;// Data wrote to data memory
       assign  TMemWrite = MemWrite; // control signal
       assign  TMemRead = MemRead; // control signal

       assign  TrReadData1 = rReadData1;
       assign  TrReadData2 = rReadData2;
       assign  TrReadSelect1 = rReadSelect1;
       assign  TrReadSelect2 = rReadSelect2;
       assign  TrWriteSelect = rWriteSelect;
       assign  TrWriteData = rWriteData;// Data wrote to Register file
       assign  TrWriteEnable = rWriteEnable;// Control singal for Reginster file
endmodule
