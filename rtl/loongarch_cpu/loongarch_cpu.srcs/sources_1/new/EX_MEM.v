`timescale 1ns / 1ps

module EX_MEM (
    input          clk,
    input          rst_n,
    input          Memtoreg_ex,
    input          Regwrite_ex,
    input          Memread_ex,
    input          Memwrite_ex,
    input [31:0]   result,
    input [31:0]   mem_wdata,
    input [4:0]    ID_EX_reg_rd,
    output reg          Memtoreg,
    output reg          Regwrite,
    output reg          Memread,
    output reg          Memwrite,
    output reg [31:0]   alu_result,
    output reg [31:0]   write_data,
    output reg [4:0]    EX_MEM_reg_rd    
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // reset 
            Memtoreg <= 1'b0;
            Regwrite <= 1'b0;
            Memread <= 1'b0;
            Memwrite <= 1'b0;
            alu_result <= 32'b0;
            write_data <= 32'b0;
            EX_MEM_reg_rd <= 5'b0;
        end else begin
            Memtoreg <= Memtoreg_ex;
            Regwrite <= Regwrite_ex;
            Memread <= Memread_ex;
            Memwrite <= Memwrite_ex;
            alu_result <= result;
            write_data <= mem_wdata;
            EX_MEM_reg_rd <= ID_EX_reg_rd;
        end
    end
    
endmodule