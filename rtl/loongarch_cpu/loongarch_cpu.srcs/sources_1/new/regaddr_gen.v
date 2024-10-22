`timescale 1ns / 1ps
`include "define.vh"

module regaddr_gen (
    input [31:0]        instruction_id,
    output reg [4:0]    read_addr1,
    output reg [4:0]    read_addr2,
    output reg [4:0]    write_addr
);

    wire [5:0] opcode = instruction_id[31:26];
    
    


endmodule