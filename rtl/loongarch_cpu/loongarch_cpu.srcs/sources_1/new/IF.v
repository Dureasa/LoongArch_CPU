`timescale 1ns / 1ps

module IF (
    input               clk,
    input               rst_n,
    input               jump,
    input [31:0]        npc2,
    output wire [31:0]  pc_id, // 程序计数器输出
    output wire [31:0]  instruction_id // 指令输出
);

    // 内部信号
    wire [31:0] pc_in;

    // 实例化 pc 模块
    pc pc_instance (
        .clk(clk),
        .rst_n(rst_n),
        .pc_in(pc_in),
        .pc_out(pc_id) // 输出直接连接到 pc_id
    );

    mux1 mux1_instance (
        .npc1(pc_id + 4),
        .npc2(npc2),
        .jump(jump),
        .pc_in(pc_in) // 输出连接到 pc_in
    );

    inst_mem inst_mem_instance (
        .addr(pc_id),
        .inst(instruction_id)
    );

endmodule