`timescale 1ns / 1ps

module alu (
    input [31:0]    us_operand1,
    input [31:0]    us_operand2,
    input [31:0]    pc,
    input [4:0]     alu_ctrl,
    output reg signed [31:0]   result,
    output reg      jump
);

    wire signed [31:0] operand1 = $signed(us_operand1);
    wire signed [31:0] operand2 = $signed(us_operand2);

    always @(*) begin
        case (alu_ctrl)
            // LU12I.W
            5'b00000: begin
                result = operand2;
                jump = 0;
            end 
            // PCADDU12I
            5'b00001: begin
                result = pc + operand2;
                jump = 0;
            end 
            // ADD.W
            5'b00010: begin
                result = operand1 + operand2;
                jump = 0;
            end 
            // SUB.W
            5'b00011: begin
                result = operand1 - operand2;
                jump = 0;
            end 
            // AND
            5'b00100: begin
                result = operand1 & operand2;
                jump = 0;
            end 
            // OR
            5'b00101: begin
                result = operand1 | operand2;
                jump = 0;
            end 
            // NOR
            5'b00110: begin
                result = ~(operand1 | operand2);
                jump = 0;
            end 
            // XOR 
            5'b00111: begin
                result = operand1 ^ operand2;
                jump = 0;
            end 
            // SLT
            5'b01000: begin
                result = (operand1 < operand2) ? 1 : 0;
                jump = 0;
            end 
            // ANDI
            5'b01001: begin
                result = operand1 & operand2;
                jump = 0;
            end
            // ORI 
            5'b01010: begin
                result = operand1 | operand2;
                jump = 0;
            end
            // XORI
            5'b01011: begin
                result = operand1 ^ operand2;
                jump = 0;
            end
            // ADDI.W
            5'b01100: begin
                result = operand1 + operand2;
                jump = 0;
            end
            // LD.W
            5'b01101: begin
                result = operand1 + operand2;
                jump = 0;
            end
            // ST.W
            5'b01110: begin
                result = operand1 + operand2;
                jump = 0;
            end
            // BEQ
            5'b01111: begin
                result = 0;                
                jump = (operand1 == operand2) ? 1 : 0;
            end
            // BNE
            5'b10000: begin
                result = 0;                
                jump = (operand1 == operand2) ? 0 : 1;
            end
            // BLT
            5'b10001: begin
                result = 0;                
                jump = (operand1 < operand2) ? 1 : 0;
            end
            // BGE
            5'b10010: begin
                result = 0;                
                jump = (operand1 < operand2) ? 0 : 1;
            end
            // BLTU
            5'b10011: begin
                result = 0;                
                jump = (us_operand1 < us_operand2) ? 1 : 0;
            end
            // BGEU
            5'b10100: begin
                result = 0;                
                jump = (us_operand1 < us_operand2) ? 0 : 1;
            end
            // JIRL
            5'b10101: begin
                result = pc + 4;                
                jump = 1;
            end
            // B
            5'b10110: begin
                result = 0;                
                jump = 1;
            end
            // BL
            5'b10111: begin
                result = pc + 4;                
                jump = 1;
            end
            default: begin
                result = 0;                
                jump = 0;                
            end
        endcase
    end
    
endmodule
