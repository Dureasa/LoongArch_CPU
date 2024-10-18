`timescale 1ns / 1ps

module imm_gen (
    input [31:0]        instruction_id,
    output reg [31:0]   immediate
);

    wire [5:0] op;
    wire [3:0] fun;
    assign op = instruction_id[31:26];
    assign fun = instruction_id[25:22];

    always @(*) begin
        // BEQ, BNE, BLT, BGE, BLTU, BGEU
        if ((op == 6'b010110) || 
            (op == 6'b010111) || 
            (op == 6'b011000) || 
            (op == 6'b011001) || 
            (op == 6'b011010) || 
            (op == 6'b011011) || 
            (op == 6'b010011)) begin
            immediate <= {{14{instruction_id[25]}},{instruction_id[25:10], 2'b0}};
        end 
        // B, BL
        else if ((op == 6'b010100) ||
            (op == 6'b010101)) begin
            immediate <= {{4{instruction_id[9]}}, instruction_id[9:0], instruction_id[25:10], 2'b0};
        end 
        // LU12I.W, PCADDU12I
        else if ((op == 6'b000101) ||
            (op == 6'b000111)) begin 
            immediate <= {instruction_id[24:5], 12'b0};           
        end  
        // ADDI.W, ST.W, LD.W
        else if ((op == 6'b000000) ||
            (op == 6'b001010)) begin 
            if ((fun == 4'b1010) || (fun == 4'b0110)) begin
                immediate <= {{20{instruction_id[21]}}, instruction_id[21:10]};
            end else begin
                immediate <= 32'b0;
            end
        end else begin
            immediate <= 32'b0;
        end
        
    end
    
endmodule