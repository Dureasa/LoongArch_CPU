`timescale 1ns / 1ps

module mux5 (
    input [1:0]         ForwardB,     // control signal
    input [31:0]        rs_data2,
    input [31:0]        wb_data,
    input [31:0]        alu_data,
    input [31:0]        reg_data,
    output reg [31:0]   operand2_tmp      // 2st data for ALU
);

    always @(*) begin
        if (ForwardB == 2'b01) begin
            operand2_tmp = wb_data;
        end else if (ForwardB == 2'b10) begin
            operand2_tmp = alu_data;
        end else if (ForwardB == 2'b11) begin
            operand2_tmp = reg_data;
        end else begin
            operand2_tmp = rs_data2;
        end
    end

endmodule


// `timescale 1ns / 1ps

// module mux5 (
//     input [1:0]         ForwardB,     // control signal
//     input [31:0]        rs_data2,
//     input [31:0]        wb_data,
//     input [31:0]        alu_data,
//     input [31:0]        reg_data,
//     output reg [31:0]   operand2_tmp      // 2st data for ALU
// );

//     always @(*) begin
//         if (ForwardB == 2'b01) begin
//             operand2_tmp = wb_data;
//         end else if (ForwardB == 2'b10) begin
//             operand2_tmp = alu_data;
//         end else if (ForwardB == 2'b11) begin
//             operand2_tmp = reg_data;
//         end else begin
//             operand2_tmp = rs_data2;
//         end
//     end

// endmodule
