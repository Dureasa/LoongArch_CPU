`timescale 1ns / 1ps


module inst_mem(
    input [31:0]        addr,  // 32位地址输入
    output reg [31:0]   inst   // 32位数据输出
    );
    
    reg [31:0] mem [0:63];
    
    // 初始化
    initial begin
        mem[0] = 32'h12345678;
        mem[1] = 32'h12345678;
    end

    // 读取操作
    always @(*) begin
        inst = mem[addr];
    end 

endmodule
