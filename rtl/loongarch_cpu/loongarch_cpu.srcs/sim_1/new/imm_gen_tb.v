`timescale 1ns / 1ps

module imm_gen_tb;

    reg [31:0] instruction_id;
    wire [31:0] immediate;

    imm_gen uut (
        .instruction_id(instruction_id),
        .immediate(immediate)
    );

    reg clk;
    initial clk = 0;
    always #5 clk = ~clk; 

    initial begin
        instruction_id = 0;
        #100;
        
        instruction_id = 32'h14000055; 
        #10;
        
        instruction_id = 32'h02800855; 
        #10;
        
        instruction_id = 32'h624A2000; 
        #10;
    
        instruction_id = 32'h524a2000; 
        #10;
    
        instruction_id = 32'h00000000; 
        #10;
        
        $finish;
    end
    
    always @(posedge clk) begin
        $display("At time %t, instruction_id = %h, immediate = %h", $time, instruction_id, immediate);
    end
    
endmodule