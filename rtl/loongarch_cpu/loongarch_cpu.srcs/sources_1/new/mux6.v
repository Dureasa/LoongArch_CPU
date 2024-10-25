`timescale 1ns / 1ps

module mux6 (
    input               ALUsrc,     // select signal
    input [31:0]        operand2_tmp,
    input [31:0]        immediate,
    output reg [31:0]   operand2      // 2st input of ALU
);

    always @(*) begin
        if (ALUsrc) begin
            operand2 = immediate;
        end else begin
            operand2 = operand2_tmp;
        end
    end

endmodule
