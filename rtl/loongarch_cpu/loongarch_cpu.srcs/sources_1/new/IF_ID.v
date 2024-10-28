`timescale 1ns / 1ps

module IF_ID(
    input           clk,
    input           rst_n,
    input           IF_ID_clear,
    input           IF_ID_hold,
    input [31:0]    pc_if,
    input [31:0]    instruction_if,
    output reg [31:0] pc_id,
    output reg [31:0] instruction_id
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pc_id <= 32'b0;
            instruction_id <= 32'b0;
        end else if (IF_ID_clear) begin
            pc_id <= 32'b0;
            instruction_id <= 32'b0;            
        end else if (IF_ID_hold) begin
            // hold
        end else begin
            pc_id <= pc_if;
            instruction_id <= instruction_if;
        end
    end

endmodule