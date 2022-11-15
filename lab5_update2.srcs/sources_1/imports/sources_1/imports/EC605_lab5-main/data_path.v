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
    output wire [31:0] memWriteData;// Data wrote to data memory
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
    
    
    //variable for control unit
    output wire ALUOp;
    output wire branch;
    output wire ALUSrc;
    output wire MemtoReg;
    
    pc_counter pcc(
        .clk(clk), 
        .rst(rst), 
        .zero_flag(flag_zero), //in
        .branch(branch), //in from control unit
        .extended(immediate), //in
        .opcode(ins[6:0]), //in
        .pc(ins_Addr) //out
    );
    
    //ports for IMEM
//    wire [31:0] ins;//instruction
    
    Instruction_Memory im(
        .Address(ins_Addr),//out to 1. control unit, 2. register file, 3.instruction delivery
	    .ReadData1(ins)//in from pc
    );
    
    
    instruction_delivery il(
        .Read_data1(rReadSelect1),//out
        .Read_data2(rReadSelect2),//out
        .immediate(immediate), //out
        .writeselect(rWriteSelect),
        .instruction(ins) //in
    );
    
    //ports for Data Memory
//    wire [31:0] memReadData;//Read data from memory
//    wire [31:0] memAddr;// Data memory Address 
//    wire [31:0] memWriteData;// Data wrote to data memory
//    wire  MemWrite; // control signal
//    wire  MemRead; // control signal
//    wire [31:0] rReadData2;
    
    DataMemory dm(
        .ReadData(memReadData),//output to memory mux
        .Address(memAddr), //in from alu output
        .ReadEnable(MemRead), //in signal from control unit   
        .WriteEnable(MemWrite), //in signal from control unit 
        .WriteData(rReadData2), //in from alu mux
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
        .ReadData1(rReadData1),//out
        .ReadData2(rReadData2),//out  
        .ReadSelect1(rReadSelect1),//in from instruction delivery
        .ReadSelect2(rReadSelect2),//in from instruction delivery
        .address(rWriteSelect), //in 
        .WriteData(rWriteData), //in from data memory mux
        .WriteEnable(rWriteEnable), //in  from control unit        
        .clk(clk),
        .rst(rst)
    );
    
    
    
    ControlUnit cu(        
        .ALUOp(ALUOp), //out
        .MemtoReg(MemtoReg), //out 
        .Branch(branch), //out 
        .MemRead(MemRead), //out 
        .MemWrite(MemWrite), //out 
        .ALUSrc(ALUSrc), //out 
        .RegWrite(rWriteEnable),//out 
        .clk(clk), //in
        .instruction(ins), //in 
        .rst(rst) //in
    );
    
    //variable for alu
    
    output wire [31:0] ALU_input2;
    
    Alu alu(
        .out(memAddr),//out
        .zero(flag_zero), //out, flag
        .a_data(rReadData1),//in
        .b_data(ALU_input2),//in
        .alu_op(ALUOp),//in       
        .clk(clk),
        .rst(rst)
    );
    
//    Mem_mux mm(
//        .out(rWriteData),//out
//        .data(memReadData),//in
//        .immed(memAddr),//in
//        .flag(MemtoReg)//in
//    );
    
    Mem_mux mm(
        .RegWriteData(rWriteData), //out to register write data
        .instruction(ins), //in
        .Readdata(memReadData), //in from data memory output 
        .ALUoutput(memAddr), //in from alu output
        .MemtoReg(MemtoReg), //in fron control unit
        .rst(rst)
    );
    
    alumux am(
        .ALU2(ALU_input2),//out to alu
        .instruction(ins),//in 
        .data2(rReadData2), //in from register
        .ALUSrc(ALUSrc),//in from control unit
        .rst(rst)
    );
    
//    reg_mux rm(
//        .out(ALU_input2),//out
//        .data(rReadData2),
//        .immed(immediate),
//        .flag(ALUSrc)
//    );
   
    
   
    
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

