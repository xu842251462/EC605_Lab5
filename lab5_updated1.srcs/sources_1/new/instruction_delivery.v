`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2022 07:48:43 PM
// Design Name: 
// Module Name: instruction_delivery
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


module instruction_delivery(
    input [31:0] instruction,
    output reg [4:0] Read_data1,
    output reg [4:0] Read_data2,
    output reg [31:0]immediate,
    output reg [4:0] writeselect
    );
    always@(instruction)begin
        case (instruction[6:0])
            7'b0110011: begin //r format
                if (instruction[14:12] == 3'b111 & instruction[31:25] ==7'b0000000) //and
                    immediate = 32'b0;
                else if (instruction[14:12] == 3'b000 & instruction[31:25] == 7'b0000000) //add
                    immediate = 32'b0;
                else if (instruction[14:12] == 3'b110 & instruction[31:25] == 7'b0000000) //or
                    immediate = 32'b0;
                else if (instruction[14:12] == 3'b000 & instruction[31:25] == 7'b0100000) //sub
                    immediate = 32'b0;
                    
                Read_data1 = instruction[19:15];
                Read_data2 = instruction[24:20];
                writeselect = 5'b0;
            end
            
            7'b1100011: begin //sb format
                if (instruction[14:12] == 3'b000) //beq
                    immediate = instruction[11:7];
                else if (instruction[14:12] == 3'b001) //bne
                    immediate = instruction[11:7];
                    
                Read_data1 = instruction[19:15];
                Read_data2 = instruction[24:20];
                writeselect = 5'b0;
            end
            
            7'b0100011: begin // sw, s format
                if (instruction[14:12] == 3'b000)
                    immediate = instruction[11:7];
                            
                Read_data1 = instruction[19:15];
                Read_data2 = instruction[24:20];
                writeselect = 5'b0;
            end
            
           7'b0000011: begin //lw, I format
           
                Read_data1 = instruction[19:15];
                Read_data2 = 5'b0;
                immediate = 32'b0;
                writeselect = 5'b0;
            end
            
            
           7'b0110111: begin //lui, u format
                Read_data1 = 5'b0;
                Read_data2 = 5'b0;
                immediate = 64'b0;
                writeselect = 5'b0;
            end
            
          7'b0010011: begin //addi, i format
                Read_data1 = instruction[19:15];
                Read_data2 = 5'b0;
                immediate = 32'b0;
                writeselect = 5'b0;
            end
            
          7'b1101111: begin //jal, uj format
                Read_data1 = 5'b0;
                Read_data2 = 5'b0;
                immediate = 32'b0;
                writeselect = 5'b0;
            end
            
          7'b1101100: begin //mov
                Read_data1 = instruction[19:15];
                Read_data2 = 5'b0;
                immediate = 32'b0;
                writeselect = 5'b1;
            end
            

        endcase
    end
endmodule
