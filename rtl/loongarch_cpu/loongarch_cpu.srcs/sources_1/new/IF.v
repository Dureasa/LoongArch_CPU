`timescale 1ns / 1ps

module IF (
    input               clk,
    input               rst_n,
    input               PC_hold,
    input               PC_sel,
    input [31:0]        npc2,
    output wire [31:0]  pc_if,
    output wire [31:0]  instruction_if 
);

    wire [31:0] pc_in;

    pc pc_instance (
        .clk(clk),
        .PC_hold(PC_hold),
        .rst_n(rst_n),
        .pc_in(pc_in),
        .pc_out(pc_if)
    );

    mux1 mux1_instance (
        .npc1(pc_if + 4),
        .npc2(npc2),
        .PC_sel(PC_sel),
        .pc_in(pc_in) 
    );

    inst_mem inst_mem_instance (
        .addr(pc_if),
        .inst(instruction_if)
    );

endmodule
