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
    output reg [31:0]   data1,
    output reg [31:0]   data2,
    output reg [31:0]   immediate,
    output reg [31:0]   instruction,   // use for alu control
    output reg [4:0]    ID_EX_reg_rs1,
    output reg [4:0]    ID_EX_reg_rs2,
    output reg [4:0]    ID_EX_reg_rd 
);

    wire Memtoreg_ctrl = main_ctrl[5];
    wire Regwrite_ctrl = main_ctrl[4];
    wire Memread_ctrl = main_ctrl[3];
    wire Memwrite_ctrl = main_ctrl[2];
    wire ALUsrc_ctrl = main_ctrl[1];
    wire pc_rs1_sel_ctrl = main_ctrl[0];

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            Memtoreg <= 1'b0;
            Regwrite <= 1'b0;
            Memread <= 1'b0;
            Memwrite <= 1'b0;
            ALUsrc <= 1'b0;
            pc_rs1_sel <= 1'b0;
            pc_ex <= 32'b0;
            read_data1 <= 32'b0;
            read_data2 <= 32'b0;
            immediate <= 32'b0;
            instruction <= 32'b0;
            ID_EX_reg_rs1 <= 5'b0;
            ID_EX_reg_rs2 <= 5'b0;
            ID_EX_reg_rd <= 5'b0;            
        end else if (ID_EX_clear) begin
            Memtoreg <= 1'b0;
            Regwrite <= 1'b0;
            Memread <= 1'b0;
            Memwrite <= 1'b0;
            ALUsrc <= 1'b0;
            pc_rs1_sel <= 1'b0;
            pc_ex <= 32'b0;
            read_data1 <= 32'b0;
            read_data2 <= 32'b0;
            immediate <= 32'b0;
            instruction <= 32'b0;
            ID_EX_reg_rs1 <= 5'b0;
            ID_EX_reg_rs2 <= 5'b0;
            ID_EX_reg_rd <= 5'b0;
        end else begin
            Memtoreg <= Memtoreg_ctrl;
            Regwrite <= Regwrite_ctrl;
            Memread <= Memread_ctrl;
            Memwrite <= Memwrite_ctrl;
            ALUsrc <= ALUsrc_ctrl;
            pc_rs1_sel <= pc_rs1_sel_ctrl;
            pc_ex <= pc_id;
            data1 <= read_data1_id;
            data2 <= read_data2_id;
            immediate <= immediate_id;
            instruction <= instruction_id;
            ID_EX_reg_rs1 <= IF_ID_reg_rs1;
            ID_EX_reg_rs2 <= IF_ID_reg_rs2;
            ID_EX_reg_rd <= IF_ID_reg_rd;

        end
    end
    
endmodule
