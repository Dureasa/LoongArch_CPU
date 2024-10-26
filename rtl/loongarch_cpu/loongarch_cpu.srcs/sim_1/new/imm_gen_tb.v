`timescale 1ns / 1ps

module testbench;
    // Inputs
    reg [3:0] a;
    reg [3:0] b;
    reg signed [3:0] at;
    reg signed [3:0] bt;

    // Outputs
    wire [3:0] c;
    wire [3:0] ct;

    // Instantiate the Unit Under Test (UUT)
    test uut (
        .a(a), 
        .b(b), 
        .at(at), 
        .bt(bt), 
        .c(c), 
        .ct(ct)
    );

    initial begin
        // Initialize Inputs
        a = 0; b = 0; at = 0; bt = 0;

        // Wait for global reset
        #100;
        
        // Add stimulus here
        // Test case 1: a = at = 4'b0001, b = bt = 4'b0010
        a = 4'b0001; at = 4'b0001; b = 4'b0010; bt = 4'b0010;
        #10; // Wait for the outputs to be updated
        
        // Test case 2: a = at = 4'b0011, b = bt = 4'b0100
        a = 4'b0011; at = 4'b0011; b = 4'b0100; bt = 4'b0100;
        #10;
        
        // Test case 3: a = at = 4'b0101, b = bt = 4'b0110
        a = 4'b0101; at = 4'b0101; b = 4'b0110; bt = 4'b0110;
        #10;
        
        // Test case 4: a = at = 4'b0111, b = bt = 4'b1000
        a = 4'b0111; at = 4'b0111; b = 4'b1000; bt = 4'b1000;
        #10;
        
        // Test case 5: a = at = 4'b1010, b = bt = 4'b1011
        a = 4'b1010; at = 4'b1010; b = 4'b1011; bt = 4'b1011;
        #10;
        
        // Test case 6: a = at = 4'b1100, b = bt = 4'b1101
        a = 4'b1100; at = 4'b1100; b = 4'b1101; bt = 4'b1101;
        #10;
        
        // Test case 7: a = at = 4'b1101, b = bt = 4'b1110
        a = 4'b1101; at = 4'b1101; b = 4'b1110; bt = 4'b1110;
        #10;
        
        // Test case 8: a = at = 4'b1110, b = bt = 4'b1111
        a = 4'b1110; at = 4'b1110; b = 4'b1111; bt = 4'b1111;
        #10;
        
        // Test case 9: a = at = 4'b1111, b = bt = 4'b0000 (edge case)
        a = 4'b1111; at = 4'b1111; b = 4'b0000; bt = 4'b0000;
        #10;
        
        // End simulation
        $finish;
    end
    
    // Monitoring changes in inputs and outputs
    initial begin
        $monitor("Time = %t, a = %b, at = %b, b = %b, bt = %b, c = %b, ct = %b", 
                 $time, a, at, b, bt, c, ct);
    end
endmodule