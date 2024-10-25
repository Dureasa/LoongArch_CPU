`timescale 1ns / 1ps

module ID_tb;

    // Inputs
    reg clk;
    reg rst_n;
    reg Ctrl_clear;
    reg Regwrite;
    reg [31:0] pc_id;
    reg [31:0] instruction_id;
    reg [31:0] write_data;
    reg [4:0] reg_rd;

    // Outputs
    wire [5:0] main_ctrl;
    wire [31:0] read_data1_id;
    wire [31:0] read_data2_id;
    wire [31:0] instruction;
    wire [31:0] immediate_id;
    wire [4:0] IF_ID_reg_rs1;
    wire [4:0] IF_ID_reg_rs2;
    wire [4:0] IF_ID_reg_rd;

    // 实例化被测试模块
    ID uut (
        .clk(clk),
        .rst_n(rst_n),
        .Ctrl_clear(Ctrl_clear),
        .Regwrite(Regwrite),
        .pc_id(pc_id),
        .instruction_id(instruction_id),
        .write_data(write_data),
        .reg_rd(reg_rd),
        .main_ctrl(main_ctrl),
        .read_data1_id(read_data1_id),
        .read_data2_id(read_data2_id),
        .instruction(instruction),
        .immediate_id(immediate_id),
        .IF_ID_reg_rs1(IF_ID_reg_rs1),
        .IF_ID_reg_rs2(IF_ID_reg_rs2),
        .IF_ID_reg_rd(IF_ID_reg_rd)
    );

    // 时钟信号生成
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 产生周期为10ns的时钟信号
    end

    // 测试序列
    initial begin
        // 初始化输入
        rst_n = 0; // 复位
        Ctrl_clear = 0;
        Regwrite = 0;
        pc_id = 0;
        instruction_id = 0;
        write_data = 0;
        reg_rd = 0;

        // 等待几个时钟周期以稳定复位
        #10;
        rst_n = 1; // 释放复位
        #10;

        // 发送一些指令和数据
        // 这里可以添加具体的测试案例，比如特定的指令和预期的行为
        instruction_id = 32'h00000013; // 一个简单的系统指令，比如NOP
        reg_rd = 5'd1; // 选择寄存器1作为写入目标
        write_data = 32'h12345678; // 写入数据
        Regwrite = 1; // 允许写入寄存器文件
        #10;

        // 模拟Ctrl_clear信号
        Ctrl_clear = 1;
        #10;
        Ctrl_clear = 0;
        #10;

        // 更多测试案例...

        // 测试结束
        $finish;
    end

endmodule