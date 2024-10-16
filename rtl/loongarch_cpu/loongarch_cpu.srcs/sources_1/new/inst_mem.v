`timescale 1ns / 1ps

module inst_mem(
    input [31:0]        addr,  // 32 bit address
    output reg [31:0]   inst   // 32 bit data output
    );
    
    reg [31:0] mem [0:63];
    
    // Initialize
    initial begin
        mem[0] = 32'h12345678;
        mem[1] = 32'h12345678;
    end

    // Read operation
    always @(*) begin
        inst = mem[addr];
    end 

endmodule
