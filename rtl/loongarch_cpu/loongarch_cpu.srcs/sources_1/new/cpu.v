`timescale 1ns / 1ps

module cpu (
    input clk,
    input rst_n
);

wire [31:0] pc;
wire [31:0] pc_if;
wire [31:0] pc_id;
wire [31:0] pc_id_t;
wire [31:0] instruction;
wire [31:0] instruction_if;
wire [31:0] instruction_id;
wire [31:0] instruction_id_t;
wire [31:0] immediate_id;
wire [31:0] immediate;
wire [5:0]  main_ctrl;
wire [31:0] npc2;
wire        PC_hold;
wire        PC_sel;
wire        IF_ID_clear;
wire        IF_ID_hold;
wire        Ctrl_clear;
wire        Regwrite;
wire [4:0]  reg_rd;
wire [31:0] write_data;
wire [31:0] alu_result;
wire [31:0] read_data1_id;
wire [31:0] read_data2_id;
wire [31:0] data1;
wire [31:0] data2;
wire [4:0]  IF_ID_reg_rs1;
wire [4:0]  IF_ID_reg_rs2;
wire [4:0]  IF_ID_reg_rd;
wire [4:0]  ID_EX_reg_rs1;
wire [4:0]  ID_EX_reg_rs2;
wire [4:0]  ID_EX_reg_rd;
wire [4:0]  EX_MEM_reg_rd;
wire        Memtoreg_ex;        
wire        Regwrite_ex;
wire        Memread_ex;
wire        Memwrite_ex;
wire        ALUsrc_ex;
wire        pc_rs1_sel_ex;
wire [1:0]  ForwardA;
wire [1:0]  ForwardB;
wire [31:0] alu_data;
wire [31:0] wb_data;
wire        jump;
wire [31:0] result;
wire [31:0] mem_wdata;
wire        Memtoreg_mem;
wire        Regwrite_mem;
wire        Memread;
wire        Memwrite;
wire [31:0] write_data_mem;
wire [31:0] read_data;
wire        Memtoreg;
wire [31:0] mem_data;
wire [31:0] alu_data_t;
wire [4:0]  MEM_WB_reg_rd;
wire        ID_EX_clear;
wire        ID_EX_clear1;
wire        ID_EX_clear2;

assign ID_EX_clear = ID_EX_clear1 | ID_EX_clear2;

IF if_instance (
    .clk(clk),
    .rst_n(rst_n),
    .PC_hold(PC_hold),
    .PC_sel(PC_sel),
    .npc2(npc2),
    .pc_if(pc_if),                  // out
    .instruction_if(instruction_if) // out
);

IF_ID if_id_instance (
    .clk(clk),
    .rst_n(rst_n),
    .IF_ID_clear(IF_ID_clear),
    .IF_ID_hold(IF_ID_hold),
    .pc_if(pc_if),
    .instruction_if(instruction_if),
    .pc_id(pc_id),                  // out
    .instruction_id(instruction_id) // out
);

ID id_instance (
    .clk(clk),
    .rst_n(rst_n),
    .Ctrl_clear(Ctrl_clear),
    .Regwrite(Regwrite),
    .pc_id(pc_id),
    .instruction_id(instruction_id),
    .write_data(write_data),
    .reg_rd(MEM_WB_reg_rd),
    .main_ctrl(main_ctrl),          // out
    .pc(pc_id_t),
    .read_data1_id(read_data1_id),
    .read_data2_id(read_data2_id),
    .instruction(instruction_id_t),
    .immediate_id(immediate_id),
    .IF_ID_reg_rs1(IF_ID_reg_rs1),
    .IF_ID_reg_rs2(IF_ID_reg_rs2),
    .IF_ID_reg_rd(IF_ID_reg_rd)
);

ID_EX id_ex_instance (
    .clk(clk),
    .rst_n(rst_n),
    .ID_EX_clear(ID_EX_clear),
    .main_ctrl(main_ctrl),
    .pc_id(pc_id_t),
    .read_data1_id(read_data1_id),
    .read_data2_id(read_data2_id),
    .immediate_id(immediate_id),
    .instruction_id(instruction_id_t),
    .IF_ID_reg_rs1(IF_ID_reg_rs1),
    .IF_ID_reg_rs2(IF_ID_reg_rs2),
    .IF_ID_reg_rd(IF_ID_reg_rd),
    .Memtoreg(Memtoreg_ex),            // out
    .Regwrite(Regwrite_ex),
    .Memread(Memread_ex),
    .Memwrite(Memwrite_ex),
    .ALUsrc(ALUsrc_ex),
    .pc_rs1_sel(pc_rs1_sel_ex),
    .pc(pc),
    .data1(data1),
    .data2(data2),
    .immediate(immediate),
    .instruction(instruction),
    .ID_EX_reg_rs1(ID_EX_reg_rs1),
    .ID_EX_reg_rs2(ID_EX_reg_rs2),
    .ID_EX_reg_rd(ID_EX_reg_rd)
);

EX ex_instance (
    .ALUsrc(ALUsrc_ex),
    .pc_rs1_sel(pc_rs1_sel_ex),
    .ForwardA(ForwardA),
    .ForwardB(ForwardB),
    .pc(pc),
    .data1(data1),
    .data2(data2),
    .immediate(immediate),
    .instruction(instruction),
    .alu_data(alu_result),
    .wb_data(wb_data),
    .jump(jump),            // out 
    .npc2(npc2),
    .result(result),
    .mem_wdata(mem_wdata)
);

EX_MEM ex_mem_instance (
    .clk(clk),
    .rst_n(rst_n),
    .Memtoreg_ex(Memtoreg_ex),
    .Regwrite_ex(Regwrite_ex),
    .Memread_ex(Memread_ex),
    .Memwrite_ex(Memwrite_ex),
    .result(result),
    .mem_wdata(mem_wdata),
    .ID_EX_reg_rd(ID_EX_reg_rd),
    .Memtoreg(Memtoreg_mem),        // out
    .Regwrite(Regwrite_mem),
    .Memread(Memread),
    .Memwrite(Memwrite),
    .alu_result(alu_result),
    .write_data(write_data_mem),
    .EX_MEM_reg_rd(EX_MEM_reg_rd)
);

MEM mem_instance (
    .clk(clk),
    .rst_n(rst_n),
    .address(alu_result),
    .write_data(write_data_mem),
    .Memread(Memread),
    .Memwrite(Memwrite),
    .read_data(read_data)           // out 
);

MEM_WB mem_wb_instance (
    .clk(clk),
    .rst_n(rst_n),
    .Memtoreg_mem(Memtoreg_mem),
    .Regwrite_mem(Regwrite_mem),
    .read_data(read_data),
    .alu_result(alu_result),
    .EX_MEM_reg_rd(EX_MEM_reg_rd),
    .Memtoreg(Memtoreg),            // out
    .Regwrite(Regwrite),
    .mem_data(mem_data),
    .alu_data(alu_data_t),
    .MEM_WB_reg_rd(MEM_WB_reg_rd)
);

WB wb_instance (
    .Memtoreg(Memtoreg),
    .mem_data(mem_data),
    .alu_data(alu_data_t),
    .write_data(write_data)         // out
);

forwarding_unit forwarding_unit_instance (
    .IF_ID_reg_rs1(ID_EX_reg_rs1),
    .IF_ID_reg_rs2(ID_EX_reg_rs2),
    .EX_MEM_reg_rd(EX_MEM_reg_rd),
    .MEM_WB_reg_rd(MEM_WB_reg_rd),
    .EX_MEM_Regwrite(Regwrite_mem),
    .MEM_WB_Regwrite(Regwrite),
    .ForwardA(ForwardA),
    .ForwardB(ForwardB)
);

hazard_detection_unit hazard_detection_unit_instance (
    .IF_ID_reg_rs1(IF_ID_reg_rs1),
    .IF_ID_reg_rs2(IF_ID_reg_rs2),
    .ID_EX_reg_rd(ID_EX_reg_rd),
    .Memread(Memread_ex),
    .PC_hold(PC_hold),
    .IF_ID_hold(IF_ID_hold),
    .ID_EX_clear(ID_EX_clear1)
);

jump_ctrl_unit jump_ctrl_unit_instance (
    .jump(jump),
    .PC_sel(PC_sel),
    .IF_ID_clear_jmp(IF_ID_clear),
    .Ctrl_clear(Ctrl_clear),
    .ID_EX_clear_jmp(ID_EX_clear2)
);
    
endmodule