`timescale 1ns / 1ps
`include "define.vh"

module control (
    input [5:0]     opcode,
    input [3:0]     fun1,
    output reg [5:0]    ctrl_signal
);

    always @(*) begin
        case (opcode) 
            `LU12IW, `PCADDU12I: begin
                ctrl_signal = 6'b010010;        
            end
            `BEQ, `BNE, `BLT, `BGE, `BLTU, `BGEU: begin
                ctrl_signal = 6'b000000;  
            end
            `JIRL: begin
                ctrl_signal = 6'b010011;               
            end
            `B: begin
                ctrl_signal = 6'b000010;      
            end
            `BL: begin
                ctrl_signal = 6'b010010;      
            end
            `AL: begin
                case (fun1)
                    `AL_R: begin
                        ctrl_signal = 6'b010000;      
                    end 
                    default: begin
                        ctrl_signal = 6'b010010;
                    end
                endcase
            end
            `MEM: begin
                case (fun1)
                    `LDW: begin
                        ctrl_signal = 6'b111010;
                    end
                    `STW: begin
                        ctrl_signal = 6'b000110;
                    end
                    default: begin
                        ctrl_signal = 6'b000000;
                    end
                endcase
            end
            default: begin
                ctrl_signal = 6'b000000; 
            end
        endcase
    end
    
endmodule
