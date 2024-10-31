`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/15 17:29:57
// Design Name: 
// Module Name: top_LEDs
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Four_LED(
    input clock,
    input reset,
    input [31:0] result,
    output reg [3:0] enable,
    output [7:0] dispcode 
);
    
    wire clk_sys;
    wire [1:0] count;
    wire [3:0] hex_num;
    wire [15:0] decimal_result;
    
    clk_div clk_div(
        .clk(clock),
        .clk_sys(clk_sys)
    );
    
    Counter4 Counter4(
        .clk(clk_sys),
        .count(count)
    );
    
    Hex_To_7Seg Hex_To_7Seg(
        .hex(hex_num),
        .dispcode(dispcode)
    );
    
    
    Binary_to_Decimal Binary_to_Decimal(
        .binary(result),
        .decimal(decimal_result)
    );
    
    Mux4_4bits Mux4_4bits(
        .choice(count),
        .in0(decimal_result[3:0]),
        .in1(decimal_result[7:4]),
        .in2(decimal_result[11:8]),
        .in3(decimal_result[15:12]),
        .out(hex_num)
    );
    
    always @(count) begin
        case(count)
            2'b00: enable = 4'b1110;
            2'b01: enable = 4'b1101;
            2'b10: enable = 4'b1011;
            2'b11: enable = 4'b0111;
        endcase
    end
    
endmodule

