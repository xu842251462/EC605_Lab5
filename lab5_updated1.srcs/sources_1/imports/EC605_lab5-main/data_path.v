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
//       input clk,
//       input rst,
    
//       output  [31:0] Tins,//instruction
//       output  [31:0] Tins_Addr,//Instructions Address
    
//       output  [31:0] TmemReadData,//Read data from memory
//       output  [31:0] TmemAddr,// Data memory Address 
//       output  [31:0] TmemWriteData,// Data wrote to data memory
//       output   TMemWrite, // control signal
//       output   TMemRead, // control signal
    
//       output  [31:0] TrReadData1, 
//       output  [31:0] TrReadData2,
//       output  [4:0] TrReadSelect1, 
//       output  [4:0] TrReadSelect2, 
//       output  [4:0] TrWriteSelect, 
//       output  [31:0] TrWriteData, // Data wrote to Register file
//       output  TrWriteEnable// Control singal for Reginster file
    clk,rst, 

    ins_Addr,
     ins,

    memAddr,memWriteData,memReadData,MemWrite,MemRead,

    rReadSelect1,rReadSelect2,rWriteSelect,rWriteData,rWriteEnable,rReadData1,rReadData2,
    
    ALUOp, branch, ALUSrc, MemtoReg, ALU_input2,
    
    immediate, flag_zero
    
    );
    
    input wire clk,rst;

    //ports for IMEM
    output wire [31:0] ins;//instruction
    output wire [31:0] ins_Addr;//Instructions Address
    
    //ports for Data Memory
    input wire [31:0] memReadData;//Read data from memory
    output wire [31:0] memAddr;// Data memory Address 
    output reg [31:0] memWriteData;// Data wrote to data memory
    output wire  MemWrite; // control signal
    output wire  MemRead; // control signal
    
    
    //ports for Register file
    input wire [31:0] rReadData1, rReadData2;
    output wire [4:0] rReadSelect1, rReadSelect2, rWriteSelect; // Control singal for Reginster file
    output wire [31:0] rWriteData; // Data wrote to Register file
    output wire rWriteEnable;// Control singal for Reginster file

     //variable for pc counter
    output wire [31:0] immediate;
    output wire flag_zero;
//    wire [31:0] ins_Addr;//Instructions Address
    
    pc_counter pcc(
        .clk(clk), 
        .rst(rst), 
        .zero_flag(flag_zero), 
        .extended(immediate), 
        .opcode(ins[6:0]), 
        .pc(ins_Addr)
    );
    
    //ports for IMEM
//    wire [31:0] ins;//instruction
    
    Instruction_Memory im(
        .Address(ins_Addr),
	    .ReadData1(ins)
    );
    
    //ports for Data Memory
//    wire [31:0] memReadData;//Read data from memory
//    wire [31:0] memAddr;// Data memory Address 
//    wire [31:0] memWriteData;// Data wrote to data memory
//    wire  MemWrite; // control signal
//    wire  MemRead; // control signal
//    wire [31:0] rReadData2;
    
    DataMemory dm(
        .ReadData(memReadData),//output
        .Address(memAddr),
        .ReadEnable(MemRead),
        .WriteData(rReadData2),
        .WriteEnable(MemWrite),
        .clk(clk),
        .rst(rst)
    );
    
    //ports for Register file
    //control singal for Reginster file
//    wire [31:0] rReadData1; 
    
//    wire [4:0] rReadSelect1; 
//    wire [4:0] rReadSelect2; 
//    wire [4:0] rWriteSelect; 
//    wire [31:0] rWriteData; // Data wrote to Register file
//    wire rWriteEnable;// Control singal for Reginster file
    
    Register_File rf(
        .ReadSelect1(rReadSelect1),//in
        .ReadSelect2(rReadSelect2),//in
        .address(rWriteSelect),
        .WriteData(rWriteData),
        .WriteEnable(rWriteEnable),
        .ReadData1(rReadData1),//out
        .ReadData2(rReadData2),//out       
        .clk(clk),
        .rst(rst)
    );
    
    //variable for control unit
    output wire ALUOp;
    output wire branch;
    output wire ALUSrc;
    output wire MemtoReg;
    
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
    
    output wire [31:0] ALU_input2;
    
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
    
    
    
    reg_mux rm(
        .data(rReadData2),
        .immed(immediate),
        .flag(ALUSrc),
        .out(ALU_input2)//out
    );
   
    
    instruction_delivery il(
        .instruction(ins), //in
        .Read_data1(rReadSelect1),//out
        .Read_data2(rReadSelect2),//out
        .immediate(immediate), //out
        .writeselect(rWriteSelect)
    );
    
//       assign  Tins = ins;//instruction
//       assign  Tins_Addr = ins_Addr;//Instructions Address

//       assign  TmemReadData = memReadData;//Read data from memory
//       assign  TmemAddr = memAddr; // Data memory Address 
//       assign  TmemWriteData = memWriteData;// Data wrote to data memory
//       assign  TMemWrite = MemWrite; // control signal
//       assign  TMemRead = MemRead; // control signal

//       assign  TrReadData1 = rReadData1;
//       assign  TrReadData2 = rReadData2;
//       assign  TrReadSelect1 = rReadSelect1;
//       assign  TrReadSelect2 = rReadSelect2;
//       assign  TrWriteSelect = rWriteSelect;
//       assign  TrWriteData = rWriteData;// Data wrote to Register file
//       assign  TrWriteEnable = rWriteEnable;// Control singal for Reginster file
       
      
       
       
//       assign  TALUOp = ALUOp;
//       assign  Tbranch = branch;
//       assign  TALUSrc = ALUSrc;
//       assign  TMemtoReg = MemtoReg;

//       assign  Tflag_zero = flag_zero;
//       assign  TALU_input2 = ALU_input2;

//       assign  Timmediate = immediate;
   
endmodule

