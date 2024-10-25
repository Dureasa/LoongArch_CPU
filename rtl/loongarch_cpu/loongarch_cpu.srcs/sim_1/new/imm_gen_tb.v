`timescale 1ns / 1ps

module add2_tb;

    // Testbench signals
    reg signed [31:0] add2_data1;
    reg signed [31:0] immediate;
    wire signed [31:0] npc2;

    // Instantiate the Unit Under Test (UUT)
    add2 uut (
        .add2_data1(add2_data1),
        .immediate(immediate),
        .npc2(npc2)
    );

    // Clock generation (not used in this testbench since it's combinational logic)
    initial begin
        // Initialize Inputs
        add2_data1 = 0;
        immediate = 0;

        // Wait for global reset (not needed in this testbench)
        #100;
        
        // Add stimulus here
            // Test case 1: Simple addition
            add2_data1 = 100;
            immediate = -5;
            #10; // Wait for 10ns to see the result
            $display("Test case 1: %d + %d = %d", add2_data1, immediate, npc2);
            
            // Test case 2: Negative numbers
            add2_data1 = -10;
            immediate = -5;
            #10;
            $display("Test case 2: %d + %d = %d", add2_data1, immediate, npc2);
            
            // Test case 3: Overflow test
            add2_data1 = 2147483647; // Max positive 32-bit signed integer
            immediate = 1;
            #10;
            $display("Test case 3: %d + %d = %d", add2_data1, immediate, npc2);
            
            // Test case 4: Underflow test
            add2_data1 = -2147483648; // Min negative 32-bit signed integer
            immediate = -1;
            #10;
            $display("Test case 4: %d + %d = %d", add2_data1, immediate, npc2);
            
            // Test case 5: Zero test
            add2_data1 = 0;
            immediate = 0;
            #10;
            $display("Test case 5: %d + %d = %d", add2_data1, immediate, npc2);
            
            // End simulation
            $finish;
    end
    
endmodule