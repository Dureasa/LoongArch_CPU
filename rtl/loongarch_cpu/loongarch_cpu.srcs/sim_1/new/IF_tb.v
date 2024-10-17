`timescale 1ns / 1ps


module IF_tb;
        // Inputs
    reg clk;
    reg rst_n;
    reg jump;
    reg [31:0] npc2;

    // Outputs
    wire [31:0] pc_id;
    wire [31:0] instruction_id;

    // 实例化 IF 模块
    IF uut (
        .clk(clk),
        .rst_n(rst_n),
        .jump(jump),
        .npc2(npc2),
        .pc_id(pc_id),
        .instruction_id(instruction_id)
    );

    // 时钟生成
    always #10 clk = ~clk; // 生成一个周期为20ns的时钟信号

    initial begin
        // 初始化
        clk = 0;
        rst_n = 0;
        jump = 0;
        npc2 = 32'd0;

        // 异步复位
        #100;
        rst_n = 1; // 释放复位

        // 正常操作
        #50;
        jump = 1; // 触发跳转
        npc2 = 32'h1000; // 设置跳转地址

        #50;
        jump = 0; // 停止跳转
        npc2 = 32'd0; // 清除跳转地址

        #100; // 等待一段时间观察结果

        // 结束仿真
        $finish;
    end

    // 监控变化
    initial begin
        $monitor("At time %t, pc = %h, instruction = %h, jump = %b, npc2 = %h",
                  $time, pc_id, instruction_id, jump, npc2);
    end

endmodule
