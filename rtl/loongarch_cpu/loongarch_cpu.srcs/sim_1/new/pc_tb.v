`timescale 1ns / 1ps

module pc_tb;

    // Inputs
    reg clk;
    reg rst_n;
    reg pc_hold;
    reg [31:0] pc_in;

    // Outputs
    wire [31:0] pc_out;

    // ʵ����������ģ��
    pc uut (
        .clk(clk),
        .rst_n(rst_n),
        .pc_hold(pc_hold),
        .pc_in(pc_in),
        .pc_out(pc_out)
    );

    // ʱ������
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // ����һ������Ϊ10ns��ʱ���ź�
    end

    // ��������
    initial begin
        // ��ʼ������
        rst_n = 0; // ����
        pc_hold = 0;
        pc_in = 32'b0;

        // �ȴ�һ��ʱ��������ȷ����λ
        #10;
        
        // �ͷŸ�λ
        rst_n = 1;
        
        // �ȴ�һ��ʱ������
        #10;
        
        // �ı�pc_in���۲�pc_out�ı仯
        pc_in = 32'h12345678;
        #10;
        
        // ����pc_out����һ������
        pc_hold = 1;
        pc_in = 32'h9abcdef0;
        #10;
        
        // �ͷ�pc_hold���۲�pc_out�ı仯
        pc_hold = 0;
        #10;
        
        // �ٴα���pc_out����һ������
        pc_hold = 1;
        #10;
        
        // �ͷ�pc_hold���۲�pc_out�ı仯
        pc_hold = 0;
        #10;
        
        // ��������
        $finish;
    end
    
    // �۲첨�α仯
    initial begin
        $dumpfile("pc.vcd");
        $dumpvars(0, pc_tb);
    end

endmodule