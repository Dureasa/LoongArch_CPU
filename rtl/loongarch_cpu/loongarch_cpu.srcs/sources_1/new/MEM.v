`timescale 1ns / 1ps

module MEM(
    input           clk,
    input           rst_n,
    input [31:0]    address,
    input [31:0]    write_data,
    input           Memread,
    input           Memwrite,
    output reg [31:0] read_data // 32-bit read data
);

    integer i;
    // Define data memory with 1024 bytes (8-bit wide)
    reg [7:0] memory [0:1023]; 

    // Write operation
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Asynchronous reset: Clear all memory locations
            for (i = 0; i < 1024; i = i + 1) begin
                memory[i] <= 8'b0;
            end
        end else if (Memwrite) begin
            // Write 32-bit data to 4 consecutive 8-bit memory locations
            memory[address[9:0]] <= write_data[7:0];       // Lower 8 bits
            memory[address[9:0] + 1] <= write_data[15:8];  // Next 8 bits
            memory[address[9:0] + 2] <= write_data[23:16]; // Next 8 bits
            memory[address[9:0] + 3] <= write_data[31:24]; // Upper 8 bits
        end
    end

    // Read operation
    always @(*) begin
        if (Memread) begin
            // Read 32-bit data from 4 consecutive 8-bit memory locations
            read_data[7:0] = memory[address[9:0]];            // Lower 8 bits
            read_data[15:8] = memory[address[9:0] + 1];       // Next 8 bits
            read_data[23:16] = memory[address[9:0] + 2];      // Next 8 bits
            read_data[31:24] = memory[address[9:0] + 3];      // Upper 8 bits
        end else begin
            read_data = 32'b0; // When not reading, set read_data to 0
        end
    end

endmodule