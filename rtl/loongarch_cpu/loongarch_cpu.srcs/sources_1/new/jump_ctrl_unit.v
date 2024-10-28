`timescale 1ns / 1ps

module jump_ctrl_unit (
    input jump,
    output reg PC_sel,
    output reg IF_ID_clear_jmp,
    output reg Ctrl_clear,
    output reg ID_EX_clear_jmp
);
    
    always @(*) begin
        if (jump) begin
            PC_sel = 1;
            IF_ID_clear_jmp = 1;
            Ctrl_clear = 1;
            ID_EX_clear_jmp = 1;
        end else begin
            PC_sel = 0;
            IF_ID_clear_jmp = 0;
            Ctrl_clear = 0;
            ID_EX_clear_jmp = 0;       
        end
    end

endmodule
