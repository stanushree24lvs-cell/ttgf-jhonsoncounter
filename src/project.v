/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module johnson_counter #(
    parameter N = 4
)(
    input  wire clk,
    input  wire rst,
    input  wire enable,
    output reg  [N-1:0] q
);

always @(posedge clk) begin
    if (rst) begin
        q <= {N{1'b0}};   // clean reset
    end
    else if (enable) begin
        q <= {q[N-2:0], ~q[N-1]};   // Johnson feedback shift
    end
end

endmodule 
