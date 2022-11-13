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
       output  TrWriteEnable,// Control singal for Reginster file
    
       output  TALUOp,
       output  Tbranch,
       output  TALUSrc,
       output  TMemtoReg,
    
       //variable for alu
       output  Tflag_zero,
       output  [31:0] TALU_input2,
        
       //variable for pc counter
       output  [31:0] Timmediate
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
        .Address(TmemAddr),
        .ReadData(TmemReadData),
        .ReadEnable(TMemRead),
        .WriteData(TmemWriteData),
        .WriteEnable(TMemWrite),
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
        .ReadSelect1(TrReadSelect1),
        .ReadSelect2(TrReadSelect2),
        .address(TrWriteSelect),
        .WriteData(TrWriteData),
        .WriteEnable(TrWriteEnable),
        .ReadData1(TrReadData1),
        .ReadData2(TrReadData2),       
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
        .MemtoReg(TMemtoReg), 
        .Branch(branch), 
        .MemRead(TMemRead), 
        .MemWrite(TMemWrite), 
        .ALUSrc(ALUSrc), 
        .RegWrite(TrWriteEnable)
    );
    
    //variable for alu
    wire flag_zero;
    wire [31:0] ALU_input2;
    
    Alu alu(
        .a_data(TrReadData1),
        .b_data(ALU_input2),
        .alu_op(ALUOp),
        .out(TmemAddr),
        .zero(flag_zero), //flag
        .clk(clk),
        .rst(rst)
    );
    
    Mem_mux mm(
        .data(TmemReadData),
        .immed(TmemAddr),
        .flag(TMemtoReg),
        .out(TrWriteData)
    );
    
     //variable for pc counter
    wire [31:0] immediate;
    
    reg_mux rm(
        .data(TrReadSelect2),
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

       assign  TALUOp = ALUOp;
       assign  Tbranch = branch;
       assign  TALUSrc = ALUSrc;
       assign  TMemtoReg = MemtoReg;

       assign  Tflag_zero = flag_zero;
       assign  TALU_input2 = ALU_input2;

       assign  Timmediate = immediate;
   
endmodule

