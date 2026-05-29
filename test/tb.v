`default_nettype none


/* This testbench just instantiates the module and makes some convenient wires
   that can be driven / tested by the cocotb test.py.
*/

`timescale 1ns / 1ps

module tb;

  // -----------------------------
  // Dump waveform
  // -----------------------------
  initial begin
    $dumpfile("tb.fst");
    $dumpvars(0, tb);
  end

  // -----------------------------
  // DUT signals (TinyTapeout style)
  // -----------------------------
  reg clk;
  reg rst_n;
  reg ena;
  reg [7:0] ui_in;
  reg [7:0] uio_in;

  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;

`ifdef GL_TEST
  wire VPWR = 1'b1;
  wire VGND = 1'b0;
`endif

  // -----------------------------
  // DUT INSTANTIATION
  // Replace with YOUR module name
  // -----------------------------
  tt_um_johnson_counter user_project (

`ifdef GL_TEST
    .VPWR(VPWR),
    .VGND(VGND),
`endif

    .ui_in(ui_in),
    .uo_out(uo_out),
    .uio_in(uio_in),
    .uio_out(uio_out),
    .uio_oe(uio_oe),
    .ena(ena),
    .clk(clk),
    .rst_n(rst_n)
  );

  // -----------------------------
  // CLOCK GENERATION
  // -----------------------------
  always #5 clk = ~clk;

  // -----------------------------
  // STIMULUS
  // -----------------------------
  initial begin

    // Init
    clk = 0;
    rst_n = 0;
    ena = 0;
    ui_in = 0;
    uio_in = 0;

    // Reset
    #20;
    rst_n = 1;

    // Enable design
    ena = 1;

    // Run simulation
    #200;

    // Disable (hold)
    ena = 0;

    #50;

    // Re-enable
    ena = 1;

    #100;

    $finish;
  end

  // -----------------------------
  // MONITOR OUTPUT
  // -----------------------------
  initial begin
    $monitor("Time=%0t | rst_n=%b | ena=%b | uo_out=%b",
              $time, rst_n, ena, uo_out);
  end

endmodule
