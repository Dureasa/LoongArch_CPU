`timescale 1ns / 1ps

module inst_mem(
    input [31:0]        addr,  // 32 bit address
    output reg [31:0]   inst   // 32 bit data output
);
    
    reg [31:0] mem [0:511];
    integer i;
    
    // Initialize
    initial begin
        mem[0] = 32'b00000010100000000000000000000001;
        mem[1] = 32'b00000010100000000000010000000010;
        mem[2] = 32'b00000010100000000010100000000011;
        mem[3] = 32'b01011000000000000001100001100000;
        mem[4] = 32'b00000000000100000000100000100100;
        mem[5] = 32'b00000000000100000000000001000001;
        mem[6] = 32'b00000000000100000000000010000010;
        mem[7] = 32'b00000010101111111111110001100011;
        mem[8] = 32'b01011011111111111110110000000000;
        mem[9] = 32'b00000000000000000000000000000000;
        mem[10] = 32'b01011011111111111111110000000000;;
        for (i = 11; i < 512; i = i + 1) begin
            mem[i] = 32'd0;
        end
    end

    wire [31:0] pc;
    assign pc = addr >> 2;

    // Read operation
    always @(*) begin
        inst = mem[pc];
    end 

endmodule
