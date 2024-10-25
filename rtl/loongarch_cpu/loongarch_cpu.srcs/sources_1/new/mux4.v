`timescale 1ns / 1ps

module mux4 (
    input [1:0]         ForwardA,     // control signal
    input [31:0]        rs_data1,
    input [31:0]        wb_data,
    input [31:0]        alu_data,
    output reg [31:0]   operand1      // 1st data for ALU
);

    always @(*) begin
        if (ForwardA == 2'b01) begin
            operand1 = wb_data;
        end else if (ForwardA == 2'b10) begin
            operand1 = alu_data;
        end else begin
            operand1 = rs_data1;
        end
    end

endmodule
