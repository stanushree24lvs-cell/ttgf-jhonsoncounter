`default_nettype none

module tt_um_johnson_counter (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       clk,
    input  wire       rst_n,
    input  wire       ena
);

reg [3:0] q;

always @(posedge clk) begin
    if (!rst_n)
        q <= 4'b0000;
    else if (ena)
        q <= {q[2:0], ~q[3]};
end

assign uo_out[3:0] = q;
assign uo_out[7:4] = 4'b0000;

assign uio_out = 8'b0;
assign uio_oe   = 8'b0;

endmodule
