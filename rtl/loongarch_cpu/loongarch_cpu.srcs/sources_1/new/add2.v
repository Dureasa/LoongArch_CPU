`timescale 1ns / 1ps

module add2 (
    input signed [31:0]        add2_data1,
    input signed [31:0]        immediate,
    output reg signed [31:0]   npc2
);
    
    always @(*) begin
        npc2 = add2_data1 + immediate;
    end

endmodule