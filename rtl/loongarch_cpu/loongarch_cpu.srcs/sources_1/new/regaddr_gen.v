`timescale 1ns / 1ps
`include "define.vh"

module regaddr_gen (
    input [31:0]        instruction_id,
    output reg [4:0]    reg_rs1,
    output reg [4:0]    reg_rs2,
    output reg [4:0]    reg_rd
);

    wire [5:0] opcode = instruction_id[31:26];
    wire [3:0] fun1 = instruction_id[25:22];

    wire [4:0] first = instruction_id[14:10];
    wire [4:0] second = instruction_id[9:5];
    wire [4:0] third = instruction_id[4:0];
    wire [4:0] zero = 5'b0;

    always @(*) begin
        case (opcode) 
            `LU12IW, `PCADDU12I: begin
                reg_rs1 = zero;
                reg_rs2 = zero;
                reg_rd = third;                
            end
            `BEQ, `BNE, `BLT, `BGE, `BLTU, `BGEU: begin
                reg_rs1 = second;
                reg_rs2 = third;
                reg_rd = zero;
            end
            `JIRL: begin
                reg_rs1 = second;
                reg_rs2 = zero;
                reg_rd = third;                
            end
            `B, `BL: begin
                reg_rs1 = zero;
                reg_rs2 = zero;
                reg_rd = zero;                
            end
            `AL: begin
                case (fun1)
                    `AL_R: begin
                        reg_rs1 = second;
                        reg_rs2 = first;
                        reg_rd = third;                          
                    end 
                    default: begin
                        reg_rs1 = second;
                        reg_rs2 = zero;
                        reg_rd = third; 
                    end
                endcase
            end
            `MEM: begin
                case (fun1)
                    `LDW: begin
                        reg_rs1 = second;
                        reg_rs2 = zero;
                        reg_rd = third;
                    end
                    default: begin
                        reg_rs1 = second;
                        reg_rs2 = third;
                        reg_rd = zero;
                    end
                endcase
            end
            default: begin
                reg_rs1 = zero;
                reg_rs2 = zero;
                reg_rd = zero;  
            end
        endcase
    end

endmodule