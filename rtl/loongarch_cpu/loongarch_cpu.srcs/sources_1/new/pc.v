`timescale 1ns / 1ps

module pc (
    input           clk,
    input           rst_n,
    input           PC_hold,
    input [31:0]    pc_in,
    output reg [31:0]   pc_out
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // if reset is active
            pc_out <= 32'b0;
        end else if (PC_hold) begin
            pc_out <= pc_out;
        end else begin
            // otherwise, update pc_out with pc_in
            pc_out <= pc_in;
        end
    end

endmodule