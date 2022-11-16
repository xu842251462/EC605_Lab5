`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2022 08:06:13 PM
// Design Name: 
// Module Name: t_instruction_dilvery
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


module t_instruction_dilvery(

    );
    
     reg [31:0] instruction;
     wire [4:0] Read_data1;
     wire [4:0] Read_data2;
     wire [31:0]immediate;
     wire [4:0] writeselect;
    
    instruction_delivery(
         .instruction(instruction),
         .Read_data1(Read_data1),
         .Read_data2(Read_data2),
         .immediate(immediate),
         .writeselect(writeselect)
    );
    
    
    
    
    always@(instruction)begin
        
        
        
        
        
    end
endmodule
