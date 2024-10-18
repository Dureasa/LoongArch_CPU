`timescale 1ns / 1ps

module mux1(
    input [31:0]        npc1,       // pc = pc + 4
    input [31:0]        npc2,       // pc = jump result
    input               jump,       // control
    output wire [31:0]  pc_in       // npc
);

    assign pc_in = jump ? npc2 : npc1;

endmodule