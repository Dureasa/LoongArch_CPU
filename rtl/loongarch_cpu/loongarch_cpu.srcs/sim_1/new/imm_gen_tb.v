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

    // ʵ����������ģ��
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

    // ʱ���ź�����
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // ��������Ϊ10ns��ʱ���ź�
    end

    // ��������
    initial begin
        // ��ʼ������
        rst_n = 0; // ��λ
        Ctrl_clear = 0;
        Regwrite = 0;
        pc_id = 0;
        instruction_id = 0;
        write_data = 0;
        reg_rd = 0;

        // �ȴ�����ʱ���������ȶ���λ
        #10;
        rst_n = 1; // �ͷŸ�λ
        #10;

        // ����һЩָ�������
        // ���������Ӿ���Ĳ��԰����������ض���ָ���Ԥ�ڵ���Ϊ
        instruction_id = 32'h00000013; // һ���򵥵�ϵͳָ�����NOP
        reg_rd = 5'd1; // ѡ��Ĵ���1��Ϊд��Ŀ��
        write_data = 32'h12345678; // д������
        Regwrite = 1; // ����д��Ĵ����ļ�
        #10;

        // ģ��Ctrl_clear�ź�
        Ctrl_clear = 1;
        #10;
        Ctrl_clear = 0;
        #10;

        // ������԰���...

        // ���Խ���
        $finish;
    end

endmodule