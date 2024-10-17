`timescale 1ns / 1ps

module inst_mem(
    input [31:0]        addr,  // 32 bit address
    output reg [31:0]   inst   // 32 bit data output
    );
    
    reg [31:0] mem [0:63];
    integer i;
    
    // Initialize
    initial begin
        mem[0] = 32'h12345678;
        mem[1] = 32'h22225678;
        for (i = 2; i < 64; i = i + 1) begin
            mem[i] = 32'd0;
        end
    end

    // Read operation
    always @(*) begin
        inst = mem[addr];
    end 

endmodule
