`timescale 1ns / 1ps

module mux1(
    input [31:0]        npc1,       // pc = pc + 4
    input [31:0]        npc2,       // pc = jump result
    input               jump,       // control
    output wire [31:0]  pc_in       // npc
);

// always @(*) begin
//     if (jump) begin
//         pc_in = npc2;
//     end else begin
//         pc_in = npc1;
//     end
// end

assign pc_in = jump ? npc2 : npc1;

endmodule