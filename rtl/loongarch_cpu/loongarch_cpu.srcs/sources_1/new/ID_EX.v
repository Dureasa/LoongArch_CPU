`timescale 1ns / 1ps

module ID_EX (
    input           clk,
    input           rst_n,
    input           ID_EX_clear,      // control signal
    input [5:0]     main_ctrl,         
    input [31:0]    pc_id,
    input [31:0]    read_data1_id,
    input [31:0]    read_data2_id,
    input [31:0]    immediate_id,
    input [31:0]    instruction_id,   // use for alu control
    input [4:0]     IF_ID_reg_rs1,
    input [4:0]     IF_ID_reg_rs2,
    input [4:0]     IF_ID_reg_rd,
    output reg          Memtoreg,
    output reg          Regwrite,
    output reg          Memread,
    output reg          Memwrite,
    output reg          ALUsrc,
    output reg          pc_rs1_sel,      
    output reg [31:0]   pc_ex,
    output reg [31:0]   read_data1,
    output reg [31:0]   read_data2,
    output reg [31:0]   immediate,
    output reg [31:0]   instruction,   // use for alu control
    output reg [4:0]    ID_EX_reg_rs1,
    output reg [4:0]    ID_EX_reg_rs2,
    output reg [4:0]    ID_EX_reg_rd 
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // 补充
        end else if (ID_EX_clear) begin
            // 补充
        end else begin
            // 补充
        end
    end
    
endmodule









