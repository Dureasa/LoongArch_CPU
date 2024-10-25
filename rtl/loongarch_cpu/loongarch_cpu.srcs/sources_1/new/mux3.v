`timescale 1ns / 1ps

module mux3 (
    input               pc_rs1_sel,     // control signal
    input [31:0]        pc_ex,
    input [31:0]        operand1,
    output reg [31:0]   add2_data1      // 1st input of Add2 module 
);

    always @(*) begin
        if (pc_rs1_sel == 0) begin
            add2_data1 = pc_ex;
        end else begin
            add2_data1 = operand1;
        end
    end

endmodule
