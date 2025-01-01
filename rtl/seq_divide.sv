// a = b*q + r
module seq_divide #(
    parameter  int WidthA   = 32,
    parameter  int WidthB   = 32,
    localparam int WidthP   = WidthA + WidthB,
    localparam int WidthCnt = $clog2(WidthB+1)
) (
    input               clk_i,
    input               rst_ni,

    input  [WidthA-1:0] a_i,
    input  [WidthB-1:0] b_i,
    input               start_i,

    output [WidthA-1:0] q_o,
    output [WidthB-1:0] r_o,
    output              finish_o
);

    logic [WidthCnt-1:0] cnt;
    logic [WidthP-1  :0] result;
    logic [WidthB    :0] sub;

    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (!rst_ni) begin
            cnt <= 'h0;
        end else if (start_i) begin
            cnt <= WidthCnt'(WidthB+1);
        end else if (|cnt) begin
            cnt <= cnt - 'h1;
        end
    end

    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (!rst_ni) begin
            result <= 'h0;
        end else if (start_i) begin
            result <= {{WidthB{1'b0}}, a_i};
        end else if (|cnt) begin
            if (sub[WidthB]) begin
                result <= {result[WidthP-2:0], 1'b0};
            end else begin
                result <= {sub[WidthB-1:0], result[WidthA-2:0], 1'b1};
            end
        end
    end

    assign sub = {1'b0, result[WidthP-1:WidthA]} - {1'b0, b_i};

    assign q_o = result[WidthA-1:0];
    assign r_o = result[WidthP-1:WidthA];
    assign finish_o = ~|cnt;

endmodule
