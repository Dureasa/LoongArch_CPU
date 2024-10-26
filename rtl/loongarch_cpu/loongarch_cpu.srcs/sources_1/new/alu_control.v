`timescale 1ns / 1ps
`include "define.vh"

module alu_control (
    input [31:0] instruction,
    output reg [4:0] alu_ctrl
);

    wire [5:0] opcode = instruction[31:26];
    wire [3:0] fun1 = instruction[25:22];
    wire [6:0] fun2 = instruction[21:15];

    always @(*) begin
        case (opcode)
            `LU12IW: alu_ctrl = 5'b00000;
            `PCADDU12I: alu_ctrl = 5'b00001;
            `AL: begin
                case (fun1)
                    `AL_R: begin
                        case (fun2)
                            `ADDW: alu_ctrl = 5'b00010;
                            `SUBW: alu_ctrl = 5'b00011;
                            `AND:  alu_ctrl = 5'b00100;
                            `OR:   alu_ctrl = 5'b00101;
                            `NOR:  alu_ctrl = 5'b00110;
                            `XOR:  alu_ctrl = 5'b00111;
                            `SLT:  alu_ctrl = 5'b01000;
                            default: alu_ctrl = 5'b01001;
                        endcase
                    end
                    `ANDI: alu_ctrl = 5'b01001;
                    `ORI:  alu_ctrl = 5'b01010;
                    `XORI: alu_ctrl = 5'b01011;
                    `ADDIW: alu_ctrl = 5'b01100;
                    default: alu_ctrl = 5'b01001;
                endcase
            end
            `MEM: begin
                case (fun1)
                    `LDW: alu_ctrl = 5'b01101;
                    `STW: alu_ctrl = 5'b01110;
                    default: alu_ctrl = 5'b01001;
                endcase
            end
            `BEQ: alu_ctrl = 5'b01111;
            `BNE: alu_ctrl = 5'b10000;
            `BLT: alu_ctrl = 5'b10001;
            `BGE: alu_ctrl = 5'b10010;
            `BLTU: alu_ctrl = 5'b10011;
            `BGEU: alu_ctrl = 5'b10100;
            `JIRL: alu_ctrl = 5'b10101;
            `B: alu_ctrl = 5'b10110;
            `BL: alu_ctrl = 5'b10111;
            default: alu_ctrl = 5'b01001;
        endcase
    end
    
endmodule
