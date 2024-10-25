`timescale 1ns / 1ps

module ID (
    input           clk,
    input           rst_n,
    input           Ctrl_clear,
    input           Regwrite,
    input [31:0]    pc_id,
    input [31:0]    instruction_id,
    input [31:0]    write_data,
    input [4:0]     reg_rd,
    output wire [5:0]    main_ctrl,
    output wire [31:0]   pc,
    output wire [31:0]   read_data1_id,
    output wire [31:0]   read_data2_id,
    output wire [31:0]   instruction,
    output wire [31:0]   immediate_id,
    output wire [4:0]    IF_ID_reg_rs1,
    output wire [4:0]    IF_ID_reg_rs2,
    output wire [4:0]    IF_ID_reg_rd
);

    wire [4:0] reg_rs1;
    wire [4:0] reg_rs2;
    wire [5:0] ctrl_signal;
    assign pc = pc_id;
    assign instruction = instruction_id;
    assign IF_ID_reg_rs1 = reg_rs1;
    assign IF_ID_reg_rs2 = reg_rs2;
    

    // address generate module 
    regaddr_gen u_regaddr_gen (
        .instruction_id(instruction_id),
        .reg_rs1(reg_rs1),
        .reg_rs2(reg_rs2),
        .reg_rd(IF_ID_reg_rd)
    );    

    // Registers file module
    reg_file u_reg_file (
        .clk(clk),
        .rst_n(rst_n),
        .RegWrite(Regwrite),
        .read_addr1(reg_rs1),
        .read_addr2(reg_rs2),
        .write_addr(reg_rd),
        .write_data(write_data),
        .read_data1(read_data1_id),
        .read_data2(read_data2_id)
    );

    // immediate generate module
    imm_gen u_imm_gen (
        .instruction_id(instruction_id),
        .immediate(immediate_id)
    );

    // control module
    control u_control (
        .opcode(instruction_id[31:26]),
        .fun1(instruction_id[25:22]),
        .ctrl_signal(ctrl_signal)
    );

    // mux2 module
    mux2 u_mux2 (
        .Ctrl_clear(Ctrl_clear),
        .ctrl_signal(ctrl_signal),
        .main_ctrl(main_ctrl)
    );
    
endmodule
