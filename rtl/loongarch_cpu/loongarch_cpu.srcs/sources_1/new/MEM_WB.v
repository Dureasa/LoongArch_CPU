`timescale 1ns / 1ps

module MEM_WB (
    input           clk,
    input           rst_n,
    input           Memtoreg_mem,
    input           Regwrite_mem,
    input [31:0]    read_data,
    input [31:0]    alu_result,
    input [4:0]     EX_MEM_reg_rd,
    output reg          Memtoreg,
    output reg          Regwrite,
    output reg [31:0]   mem_data,
    output reg [31:0]   alu_data,
    output reg [4:0]    MEM_WB_reg_rd
);

    always @(posedge clk or negedge rst_n) begin
        // reset
        if (!rst_n) begin
            Memtoreg <= 1'b0;
            Regwrite <= 1'b0;
            mem_data <= 32'b0;
            alu_data <= 32'b0;
            MEM_WB_reg_rd <= 5'b0;
        end else begin
            Memtoreg <= Memtoreg_mem;
            Regwrite <= Regwrite_mem;
            mem_data <= read_data;
            alu_data <= alu_result;
            MEM_WB_reg_rd <= EX_MEM_reg_rd;
        end
    end
    
endmodule