// -----------------------------------------------------------------------------
// File Name: seq_multiply.sv
// Description:
//     This module implements a sequential multiplier that computes the product
//     of two integers. The multiplication process takes WidthB+1 clock cycles
//     and uses a shift-and-add algorithm, where WidthB represents the bit
//     width of the multiplier.
//
// Author: shsjung (github.com/shsjung)
// Date Created: 01-01-2025
// -----------------------------------------------------------------------------

`define SIM_LOG

module seq_multiply #(
    parameter  int WidthA   = 32,
    parameter  int WidthB   = 32,
    localparam int WidthC   = WidthA + WidthB,
    localparam int WidthCnt = $clog2(WidthB+1)
) (
    input               clk_i,
    input               rst_ni,

    input  [WidthA-1:0] a_i,
    input  [WidthB-1:0] b_i,
    input               start_i,

    output [WidthC-1:0] c_o,
    output              finish_o
);

    logic [WidthCnt-1:0] cnt;
    logic [WidthC-1  :0] result;
    logic [WidthA    :0] add;

    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (!rst_ni) begin
            cnt <= 'h0;
        end else if (start_i) begin
            cnt <= WidthCnt'(WidthB);
        end else if (|cnt) begin
            cnt <= cnt - 'h1;
        end
    end

    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (!rst_ni) begin
            result <= 'h0;
        end else if (start_i) begin
            result <= {{WidthA{1'b0}}, b_i};
        end else if (|cnt) begin
            if (result[0]) begin
                result <= {add, result[WidthB-1:1]};
            end else begin
                result <= {1'b0, result[WidthC-1:1]};
            end
        end
    end

    assign add = {1'b0, result[WidthC-1:WidthB]} + {1'b0, a_i};

    assign c_o = result;
    assign finish_o = ~|cnt;

`ifdef SIM_LOG
    always_ff @(posedge start_i) begin
        if (start_i)
            $display("seq_multiply start : %d %d", a_i, b_i);
    end
    always_ff @(posedge finish_o) begin
        if (finish_o)
            $display("seq_multiply finish: %d", c_o);
    end
`endif

endmodule
