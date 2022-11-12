`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2022 03:52:08 PM
// Design Name: 
// Module Name: DataPath
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


module Datapath(
    input clk,
    input rst
    
    );
    
    //ports for IMEM
    wire [31:0] ins;//instruction
    wire [31:0] ins_Addr;//Instructions Address
    
    Instruction_Memory im(
        .Address(ins_Addr),
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
    
    //variable for control unit
    wire ALUOp;
    wire branch;
    wire ALUSrc;
    wire MemtoReg;
    
    ControlUnit cu(
        .clk(clk), 
        .instruction(ins), 
        .rst(rst), 
        .ALUOp(ALUOp), 
        .MemtoReg(MemtoReg), 
        .Branch(branch), 
        .MemRead(MemRead), 
        .MemWrite(MemWrite), 
        .ALUSrc(ALUSrc), 
        .RegWrite(rWriteEnable)
    );
    
    //variable for alu
    wire flag_zero;
    wire [31:0] ALU_input2;
    
    Alu alu(
        .a_data(rReadData1),
        .b_data(ALU_input2),
        .alu_op(ALUOp),
        .out(memAddr),
        .zero(flag_zero), //flag
        .clk(clk),
        .rst(rst)
    );
    
    Mem_mux mm(
        .data(memReadData),
        .immed(memAddr),
        .flag(MemtoReg),
        .out(rWriteData)
    );
    
     //variable for pc counter
    wire [31:0] immediate;
    
    reg_mux rm(
        .data(rReadSelect2),
        .immed(immediate),
        .flag(ALUSrc),
        .out(ALU_input2)
    );
    
 
    pc_counter pcc(
        .clk(clk), 
        .rst(rst), 
        .zero_flag(flag_zero), 
        .extended(immediate), 
        .opcode(ins[6:0]), 
        .pc(ins_Addr)
    );
    
endmodule
