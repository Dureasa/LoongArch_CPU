`timescale 1ns / 1ps

module mux1(
    input [31:0]        npc1,       // pc = pc + 4
    input [31:0]        npc2,       // pc = jump result
    input               PC_sel,     // control
    output wire [31:0]  pc_in       // output: next pc
);

    always @(*) begin
        if (PC_sel == 0) begin
            pc_in = npc1;
        end else begin 
            pc_in = npc2;
        end
    end

endmodule