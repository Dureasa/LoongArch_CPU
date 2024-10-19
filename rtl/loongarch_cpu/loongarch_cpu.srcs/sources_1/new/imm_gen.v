`timescale 1ns / 1ps
`include "define.vh"

module imm_gen (
    input [31:0]        instruction_id,
    output reg [31:0]   immediate
);

    wire [5:0] op = instruction_id[31:26];
    wire [3:0] fun1 = instruction_id[25:22];

    always @(*) begin
        // opcode
        case (op)
            // LU12I.W, PCADDU12I
            `LU12I: immediate <= {instruction_id[24:5], 12'b0};
            `PCADDU12I: immediate <= {instruction_id[24:5], 12'b0};

            // BEQ, BNE, BLT, BGE, BLTU, BGEU
            `BEQ: immediate <= {{14{instruction_id[25]}},{instruction_id[25:10], 2'b0}};            
            `BNE: immediate <= {{14{instruction_id[25]}},{instruction_id[25:10], 2'b0}};            
            `BLT: immediate <= {{14{instruction_id[25]}},{instruction_id[25:10], 2'b0}};            
            `BGE: immediate <= {{14{instruction_id[25]}},{instruction_id[25:10], 2'b0}};            
            `BLTU: immediate <= {{14{instruction_id[25]}},{instruction_id[25:10], 2'b0}};
            `BGEU: immediate <= {{14{instruction_id[25]}},{instruction_id[25:10], 2'b0}};

            // B, BL
            `B: immediate <= {{4{instruction_id[9]}}, instruction_id[9:0], instruction_id[25:10], 2'b0};
            `BL: immediate <= {{4{instruction_id[9]}}, instruction_id[9:0], instruction_id[25:10], 2'b0};

            // MEM (LDW, STW)
            `MEM: immediate <= {{20{instruction_id[21]}}, instruction_id[21:10]};

            // AL (ANDI, ORI, XORI)
            `AL: begin
                case (fun1)
                    `ANDI: immediate <= {{20{1'b0}}, instruction_id[21:10]};
                    `ORI: immediate <= {{20{1'b0}}, instruction_id[21:10]};
                    `XORI: immediate <= {{20{1'b0}}, instruction_id[21:10]};
                    `ADDIW: immediate <= {{20{instruction_id[21]}}, instruction_id[21:10]};
                    default: immediate <= 32'b0;
                endcase
            end 
            
            default: immediate <= 32'b0;

        endcase
    end
    
endmodule