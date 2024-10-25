`timescale 1ns / 1ps

module mux4 (
    input [1:0]         ForwardB,     // control signal
    input [31:0]        rs_data2,
    input [31:0]        wb_data,
    input [31:0]        alu_data,
    output reg [31:0]   operand2      // 2st data for ALU
);

    always @(*) begin
        if (ForwardB == 2'b01) begin
            operand2 = wb_data;
        end else if (ForwardB == 2'b10) begin
            operand2 = alu_data;
        end else begin
            operand2 = rs_data2;
        end
    end

endmodule
