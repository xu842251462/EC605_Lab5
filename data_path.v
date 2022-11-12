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

    clk,rst,
    
    ins_Addr,
    ins,
    
    memAddr,memWriteData,memReadData,MemWrite,MemRead,
    
    rReadSelect1,rReadSelect2,rWriteSelect,rWriteData,rWriteEnable,rReadData1,rReadData2
    );

    input clk,rst;

    //ports for IMEM
    input  [31:0] ins;//instruction
    output [31:0] ins_Addr;//Instructions Address
    
    
    //ports for Data Memory
    input [31:0] memReadData;//Read data from memory
    output [31:0] memAddr;// Data memory Address 
    output [31:0] memWriteData;// Data wrote to data memory
    output  MemWrite; // control signal
    output  MemRead; // control signal
    
    
    //ports for Register file
    input [31:0] rReadData1, rReadData2;
    output [4:0] rReadSelect1, rReadSelect2, rWriteSelect; // Control singal for Reginster file
    output [31:0] rWriteData; // Data wrote to Register file
    output rWriteEnable;// Control singal for Reginster file
    
    //add additional module needed for implementation 
endmodule

