`timescale 1ns / 1ps

module pc_tb;

    // Inputs
    reg clk;
    reg rst_n;
    reg pc_hold;
    reg [31:0] pc_in;

    // Outputs
    wire [31:0] pc_out;

    // 实例化待测试模块
    pc uut (
        .clk(clk),
        .rst_n(rst_n),
        .pc_hold(pc_hold),
        .pc_in(pc_in),
        .pc_out(pc_out)
    );

    // 时钟生成
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 产生一个周期为10ns的时钟信号
    end

    // 测试序列
    initial begin
        // 初始化输入
        rst_n = 0; // 重置
        pc_hold = 0;
        pc_in = 32'b0;

        // 等待一个时钟周期以确保复位
        #10;
        
        // 释放复位
        rst_n = 1;
        
        // 等待一个时钟周期
        #10;
        
        // 改变pc_in并观察pc_out的变化
        pc_in = 32'h12345678;
        #10;
        
        // 保持pc_out不变一个周期
        pc_hold = 1;
        pc_in = 32'h9abcdef0;
        #10;
        
        // 释放pc_hold并观察pc_out的变化
        pc_hold = 0;
        #10;
        
        // 再次保持pc_out不变一个周期
        pc_hold = 1;
        #10;
        
        // 释放pc_hold并观察pc_out的变化
        pc_hold = 0;
        #10;
        
        // 结束测试
        $finish;
    end
    
    // 观察波形变化
    initial begin
        $dumpfile("pc.vcd");
        $dumpvars(0, pc_tb);
    end

endmodule