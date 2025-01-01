// c = a*b
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

endmodule
