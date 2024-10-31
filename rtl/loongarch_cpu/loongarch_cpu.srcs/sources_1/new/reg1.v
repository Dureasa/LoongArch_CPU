`timescale 1ns / 1ps

module reg1 (
    input clk,
    input rst_n,
    input IF_ID_clear,
    output reg inst_clear
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            inst_clear <= 0;
        end else begin
            inst_clear <= IF_ID_clear;
        end
    end
    
endmodule