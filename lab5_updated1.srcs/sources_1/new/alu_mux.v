module alumux(instruction, data2, ALUSrc, ALU2, rst);
    
    input [31:0] instruction;
    input [31:0] data2;
    input ALUSrc, rst;
    
    output reg [63:0] ALU2;
       
    always @(posedge rst, ALUSrc, instruction, data2)
    begin
        if ( rst )
            ALU2 = 0;
        
        else if ( ALUSrc == 1)
            ALU2 = $signed(instruction[31:0]);
        
        else if ( ALUSrc == 0)
            ALU2 = data2;
    end
endmodule
