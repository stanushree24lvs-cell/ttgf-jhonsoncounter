`default_nettype none
`timescale 1ns / 1ps

/* This testbench just instantiates the module and makes some convenient wires
   that can be driven / tested by the cocotb test.py.
*/

module tb_johnson_counter;

    // Parameters
    parameter N = 4;

    // Testbench signals
    reg clk;
    reg rst;
    reg enable;
    wire [N-1:0] q;

    // DUT (Design Under Test)
    johnson_counter #(
        .N(N)
    ) uut (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .q(q)
    );

    // Clock generation (100 MHz equivalent: 10ns period)
    always #5 clk = ~clk;

    // Stimulus
    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        enable = 0;

        // Hold reset for a few cycles
        #20;
        rst = 0;

        // Enable counter
        enable = 1;

        // Let it run for some cycles
        #100;

        // Disable counter (test pause feature)
        enable = 0;

        #30;

        // Re-enable counter
        enable = 1;

        #80;

        // Finish simulation
        $stop;
    end

    // Monitor output
    initial begin
        $monitor("Time=%0t | rst=%b | enable=%b | q=%b",
                  $time, rst, enable, q);
    end

endmodule
