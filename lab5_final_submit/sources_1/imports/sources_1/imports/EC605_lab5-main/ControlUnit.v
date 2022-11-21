module ControlUnit(clk, instruction, rst, ALUOp, MemtoReg, Branch, MemRead, MemWrite, ALUSrc, RegWrite, jump);

    input [31:0] instruction;
    input rst,clk;
//    input  [63:0] pc;
    output reg MemtoReg, RegWrite, MemRead, MemWrite, ALUSrc, Branch, jump;
    output reg [3:0]ALUOp;
//    wire [3:0] opcode;
//    wire [2:0] fun3;
//    wire [6:0] fun7;
    
//    assign opcode = instruction[6:0];
//    assign fun3 = instruction[14:12];
//    assign fun7 = instruction[31:25];

    
    always @(instruction)
        begin
        if (instruction[6:0] == 7'b0110011 & instruction[14:12] == 3'b111 & instruction[31:25] ==7'b0000000)//and r_type
            begin
                    MemtoReg=0;
                    MemRead=0;
                    MemWrite=0;
                    ALUOp=4'b0000;
                    ALUSrc=0;
                    RegWrite=1;
                    Branch=0;
                    jump = 0;
            end 
      
        else if (instruction[6:0] == 7'b0110011 & instruction[14:12] == 3'b000 & instruction[31:25] == 7'b0000000)//add
            begin
                    MemtoReg=0;
                    MemRead=0;
                    MemWrite=0;
                    ALUOp=4'b0010;
                    ALUSrc=0;
                    RegWrite=1;
                    Branch=0;
                    jump = 0;
            end
        
        else if (instruction[6:0] == 7'b0110011 & instruction[14:12] == 3'b110 & instruction[31:25] == 7'b0000000)//or
             begin
                    MemtoReg=0;
                    MemRead=0;
                    MemWrite=0;
                    ALUOp=4'b0001;
                    ALUSrc=0;
                    RegWrite=1;
                    Branch=0;
                    jump = 0;
            end
        
        else if (instruction[6:0] == 7'b1100011 & instruction[14:12] == 3'b000)//BEQ
            begin
                    MemtoReg=0;
                    MemRead=0;
                    MemWrite=0;
                    ALUOp=4'b0110;
                    ALUSrc=0;
                    RegWrite=0;
                    Branch=1;
                    jump = 0;
            end
        
        else if (instruction[6:0] == 7'b1100011 & instruction[14:12] == 3'b001)//bne
            begin
                    MemtoReg=0;
                    MemRead=0;
                    MemWrite=0;
                    ALUOp=4'b1110;
                    ALUSrc=0;
                    RegWrite=0;
                    Branch=1;
                    jump = 0;
            end
        
        else if (instruction[6:0] == 7'b0110011 & instruction[14:12] == 3'b000 & instruction[31:25] == 7'b0100000)//SUB
            begin
                    MemtoReg=0;
                    MemRead=0;
                    MemWrite=0;
                    ALUOp=4'b0110;
                    ALUSrc=0;
                    RegWrite=1;
                    Branch=0;
                    jump = 0;
            end
        
        else if (instruction[6:0] == 7'b0100011 & instruction[14:12] == 3'b010)//sw
            begin
                    MemtoReg=0;
                    MemRead=0;
                    MemWrite=1;
                    ALUOp=4'b0010;
                    ALUSrc=1;
                    RegWrite=0;
                    Branch=0;
                    jump = 0;
            end
        
         else if (instruction[6:0] == 7'b0000011 & instruction[14:12] == 3'b010)//lw
            begin
                    MemtoReg=1;
                    MemRead=1;
                    MemWrite=0;
                    //                
                    ALUOp=4'b0010;
                    ALUSrc=1;
                    RegWrite=1;
                    Branch=0;
                    jump = 0;
            end
         else if (instruction[6:0] == 7'b0110111)//lui
            begin
                    MemtoReg=0;
                    MemRead=0;
                    MemWrite=0;
                    ALUOp=4'b0111;
                    ALUSrc=1;
                    RegWrite=1;
                    Branch=0;
                    jump = 0;
            end
         else if (instruction[6:0] == 7'b0010011 & instruction[14:12] == 3'b000)//addi
            begin
                    MemtoReg=0;
                    MemRead=0;
                    MemWrite=0;
                    ALUOp=4'b0010;
                    ALUSrc=1;
                    RegWrite=1;
                    Branch=0;
                    jump = 0;
            end
         else if (instruction[6:0] == 7'b1101111)//jal
            begin
                    MemtoReg=0;
                    MemRead=0;
                    MemWrite=0;
                    //
                    ALUOp=4'b0010;
                    ALUSrc=0;
                    RegWrite=0;
                    Branch = 0;
                    jump = 1;
            end
        end
        
endmodule


