`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2022 02:25:44 PM
// Design Name: 
// Module Name: t_data_path
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


module t_data_path(

    );
    reg clk;
    reg rst;

    //ports for IMEM
    wire  [31:0] ins;//instruction
    wire [31:0] ins_Addr;//Instructions Address
    
    //OUTPUT
    wire  [31:0] TmemReadData;//Read data from memory
    wire [31:0] TmemAddr;// Data memory Address 
    wire [31:0] TmemWriteData;// Data wrote to data memory
    wire  TMemWrite; // control signal
    wire  TMemRead; // control signal
    
    // Control singal for Reginster file
    wire [31:0] TrReadData1; 
    wire [31:0] TrReadData2;
    wire [4:0] TrReadSelect1; 
    wire [4:0] TrReadSelect2; 
    wire [4:0] TrWriteSelect; 
    wire [31:0] TrWriteData; // Data wrote to Register file
    wire TrWriteEnable;// Control singal for Reginster file
    
    Datapath uut(
        clk,rst,
        ins_Addr,
        ins,
        TmemAddr,TmemWriteData,TmemReadData,TMemWrite,TMemRead,
        TrReadSelect1,TrReadSelect2,TrWriteSelect,TrWriteData,TrWriteEnable,TrReadData1,TrReadData2
    );
    
    initial
        begin
        clk = 1;
        rst = 1;
        
        #1
        rst = 0;
        
        #100
        rst = 0;
    end
    
    always
        #10 clk = !clk;
   


endmodule
