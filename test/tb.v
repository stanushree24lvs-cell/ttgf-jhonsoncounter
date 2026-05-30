`timescale 1ns / 1ps
`default_nettype none

module tb;

    reg clk = 0;
    reg rst_n = 0;
    reg ena = 1;
    wire [7:0] uo_out;

    // clock
    always #5 clk = ~clk;

    // DUT
    tt_um_johnson_counter dut (
        .ui_in(0),
        .uo_out(uo_out),
        .uio_in(0),
        .uio_out(),
        .uio_oe(),
        .clk(clk),
        .rst_n(rst_n),
        .ena(ena)
    );

    initial begin
        $dumpfile("tb.fst");
        $dumpvars(0, tb);

        rst_n = 0;
        #20;
        rst_n = 1;

        #200;

        $finish;
    end

endmodule
