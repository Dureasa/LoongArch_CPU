`timescale 1ns / 1ps

module reg_file(
    input               clk,
    input               rst_n,          // Reset signal, active low
    input               RegWrite,       // Write enable signal
    input [4:0]         read_addr1,     // Read address 1
    input [4:0]         read_addr2,     // Read address 2
    input [4:0]         write_addr,     // Write address
    input [31:0]        write_data,     // Write data
    output reg [31:0]   read_data1,     // Read data 1
    output reg [31:0]   read_data2      // Read data 2
);

    reg [31:0] gr [0:31];

    // Read logic
    always @(*) begin
        read_data1 = gr[read_addr1];
        read_data2 = gr[read_addr2];
    end

    // Sequential logic
    integer i;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset, set all registers to zero
            for (i = 0; i < 32; i = i + 1) begin
                gr[i] <= 32'b0;
            end
            disable fork;
        end else if (RegWrite) begin
            // Write enable signal is active, write data to the register
            gr[write_addr] <= write_data; 
        end
    end

endmodule