`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/09/06 19:51:44
// Design Name: 
// Module Name: Binary_to_Decimal
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


module Binary_to_Decimal(
    input [31:0] binary,
    output reg [15:0] decimal
);
    integer i;
    reg [31:0] temp;
    
    always @(*) begin
        temp = binary;
        decimal = 0;
        
        for (i = 0; i < 4; i = i + 1) begin
            decimal = decimal << 4;
            decimal = decimal | (temp % 10);
            temp = temp / 10;
        end
    end
endmodule
