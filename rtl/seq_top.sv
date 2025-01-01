// -----------------------------------------------------------------------------
// File Name: seq_top.sv
// Description:
//     A module which includes the following components:
//       1. A sequential multiplier
//       2. A sequential divider
//     This module has two inputs:
//       1. a: multiplicand / dividend
//       2. b: multiplier / divisor
//     This module has three outputs:
//       1. c: product
//       2. q: quotient
//       3. r: remainder
//
// Author: shsjung (github.com/shsjung)
// Date Created: 01-01-2025
// -----------------------------------------------------------------------------

module seq_top #(
    parameter  int WidthA = 32,
    parameter  int WidthB = 32,
    localparam int WidthC = WidthA + WidthB
) (
    input               clk_i,
    input               rst_ni,

    input  [WidthA-1:0] a,
    input  [WidthB-1:0] b,
    input               start,

    output [WidthC-1:0] c,
    output [WidthA-1:0] q,
    output [WidthB-1:0] r,
    output              finish
);

    logic finish_multiply, finish_divide;

    seq_multiply #(
        .WidthA (WidthA),
        .WidthB (WidthB)
    ) inst_multiplier (
        .clk_i    (clk_i),
        .rst_ni   (rst_ni),

        .a_i      (a),
        .b_i      (b),
        .start_i  (start),

        .c_o      (c),
        .finish_o (finish_multiply)
    );

    seq_divide #(
        .WidthA (WidthA),
        .WidthB (WidthB)
    ) inst_divider (
        .clk_i    (clk_i),
        .rst_ni   (rst_ni),

        .a_i      (a),
        .b_i      (b),
        .start_i  (start),

        .q_o      (q),
        .r_o      (r),
        .finish_o (finish_divide)
    );

    assign finish = finish_multiply & finish_divide;

endmodule

