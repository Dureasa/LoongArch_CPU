`timescale 1ns / 1ps

module mux2 (
    input               Ctrl_clear,
    input [5:0]         ctrl_signal,
    output reg [5:0]    main_ctrl
);

    always @(*) begin
        if (Ctrl_clear == 0) begin
            main_ctrl = ctrl_signal;
        end else begin
            main_ctrl = 6'b0;
        end
    end

endmodule