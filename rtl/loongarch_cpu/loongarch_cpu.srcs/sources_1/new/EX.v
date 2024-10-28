`timescale 1ns / 1ps

module EX (
    input          ALUsrc,
    input          pc_rs1_sel,
    input [1:0]    ForwardA,
    input [1:0]    ForwardB,
    input [31:0]   pc,
    input [31:0]   data1,
    input [31:0]   data2,
    input [31:0]   immediate,
    input [31:0]   instruction,  
    input [31:0]   alu_data,
    input [31:0]   wb_data,
    output wire          jump,
    output wire [31:0]   npc2,
    output wire [31:0]   result,
    output reg [31:0]    mem_wdata
);

    wire [31:0] operand1;       // mux4 to mux3 and alu
    wire [31:0] operand2;       // mux6 to alu
    wire [31:0] add2_data1;     // mux3 to add2
    wire [31:0] operand2_tmp;   // mux5 to mux6 and mem_wdata
    wire [4:0]  alu_ctrl;    // alu_control to alu

    mux4 u_mux4(
        .ForwardA(ForwardA),
        .rs_data1(data1),
        .wb_data(wb_data),
        .alu_data(alu_data),
        .operand1(operand1)
    );

    mux3 u_mux3(
        .pc_rs1_sel(pc_rs1_sel),
        .pc_ex(pc),
        .operand1(operand1),
        .add2_data1(add2_data1)
    );

    add2 u_add2(
        .add2_data1(add2_data1),
        .immediate(immediate),
        .npc2(npc2)
    );

    mux5 u_mux5(
        .ForwardB(ForwardB),
        .rs_data2(data2),
        .wb_data(wb_data),
        .alu_data(alu_data),
        .operand2_tmp(operand2_tmp)
    );

    mux6 u_mux6(
        .ALUsrc(ALUsrc),
        .operand2_tmp(operand2_tmp),
        .immediate(immediate),
        .operand2(operand2)
    );

    alu_control u_alu_control (
        .instruction(instruction),
        .alu_ctrl(alu_ctrl)
    );

    alu u_alu(
        .us_operand1(operand1),
        .us_operand2(operand2),
        .pc(pc),
        .alu_ctrl(alu_ctrl),
        .result(result),
        .jump(jump)
    );

    always @(*) begin
        mem_wdata = operand2_tmp;
    end
    
endmodule