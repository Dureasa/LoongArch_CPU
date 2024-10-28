`timescale 1ns / 1ps

module hazard_detection_unit (
    input [4:0] IF_ID_reg_rs1,
    input [4:0] IF_ID_reg_rs2,
    input [4:0] ID_EX_reg_rd,
    input       Memread,
    output reg PC_hold,
    output reg IF_ID_hold,
    output reg ID_EX_clear
);

    // MEMORY HAZARD
    always @(*) begin
        if (Memread && (ID_EX_reg_rd == IF_ID_reg_rs1 || ID_EX_reg_rd == IF_ID_reg_rs2)) begin
            PC_hold = 1;
            IF_ID_hold = 1; 
            ID_EX_clear = 1;
        end else begin
            PC_hold = 0;  
            IF_ID_hold = 0; 
        end
    end

endmodule