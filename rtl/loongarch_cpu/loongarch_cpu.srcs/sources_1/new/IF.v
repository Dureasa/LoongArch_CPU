`timescale 1ns / 1ps

module IF (
    input               clk,
    input               PC_hold,
    input               rst_n,
    input               jump,
    input [31:0]        npc2,
    output wire [31:0]  pc_id,
    output wire [31:0]  instruction_id 
);

    wire [31:0] pc_in;

    pc pc_instance (
        .clk(clk),
        .PC_hold(PC_hold),
        .rst_n(rst_n),
        .pc_in(pc_in),
        .pc_out(pc_id)
    );

    mux1 mux1_instance (
        .npc1(pc_id + 4),
        .npc2(npc2),
        .jump(jump),
        .pc_in(pc_in) 
    );

    inst_mem inst_mem_instance (
        .addr(pc_id),
        .inst(instruction_id)
    );

endmodule