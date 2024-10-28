`timescale 1ns / 1ps

module mux7 (
    input               Memtoreg,     // select signal
    input [31:0]        mem_data,
    input [31:0]        alu_data,
    output reg [31:0]   write_data      // rewrite data
);

    always @(*) begin
        if (Memtoreg) begin
            write_data = mem_data;
        end else begin
            write_data = alu_data;
        end
    end

endmodule
