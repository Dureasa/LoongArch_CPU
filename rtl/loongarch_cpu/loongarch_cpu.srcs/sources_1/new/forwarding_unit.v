`timescale 1ns / 1ps

module forwarding_unit (
    input [4:0] ID_EX_reg_rs1,
    input [4:0] ID_EX_reg_rs2,
    input [4:0] IF_ID_reg_rd,
    input [4:0] EX_MEM_reg_rd,
    input [4:0] MEM_WB_reg_rd,
    input       EX_MEM_Regwrite,
    input       MEM_WB_Regwrite,
    input       IF_ID_Regwrite,
    output reg [1:0] ForwardA,
    output reg [1:0] ForwardB
);

    wire ex_a = EX_MEM_Regwrite && (EX_MEM_reg_rd != 0) && (EX_MEM_reg_rd == ID_EX_reg_rs1);
    wire ex_b = EX_MEM_Regwrite && (EX_MEM_reg_rd != 0) && (EX_MEM_reg_rd == ID_EX_reg_rs2);
    wire mem_a = MEM_WB_Regwrite && (MEM_WB_reg_rd != 0) && (!ex_a) && (MEM_WB_reg_rd == ID_EX_reg_rs1);
    wire mem_b = MEM_WB_Regwrite && (MEM_WB_reg_rd != 0) && (!ex_b) && (MEM_WB_reg_rd == ID_EX_reg_rs2);
    wire if_a = IF_ID_Regwrite && (IF_ID_reg_rd != 0) && (!ex_a) && (!mem_a) && (IF_ID_reg_rd == ID_EX_reg_rs1);
    wire if_b = IF_ID_Regwrite && (IF_ID_reg_rd != 0) && (!ex_b) && (!mem_b) && (IF_ID_reg_rd == ID_EX_reg_rs2);

    always @(*) begin
        ForwardA = 2'b00;
        ForwardB = 2'b00;

        if (ex_a) begin
            ForwardA = 2'b10;
        end else if (mem_a) begin
            ForwardA = 2'b01;
        end else if (if_a) begin
            ForwardA = 2'b11;
        end

        if (ex_b) begin
            ForwardB = 2'b10;
        end else if (mem_b) begin
            ForwardB = 2'b01;
        end else if (if_b) begin
            ForwardB = 2'b11;
        end
    end

endmodule
