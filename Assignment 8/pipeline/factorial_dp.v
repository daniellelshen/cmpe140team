module factorial_dp(
    input [31:0] n,
    input clk, ld_CNT, en_CNT, ld_REG, sel_MUX, OE_BUF,
    output [31:0] product,
    output x_GT_1, x_GT_12
);

wire [31:0] out_CNT;
wire [31:0] out_MUL, out_MUX, out_REG;
reg [31:0] one = 32'b0001, twelve = 32'b1100;
CNT CNT(
    .D (n),
    .ld (ld_CNT),
    .en (en_CNT),
    .Q (out_CNT),
    .clk (clk)
);

CMP CMP1 (
    .A (out_CNT),
    .B (one),
    .GT (x_GT_1)
);

CMP CMP12 (
    .A (out_CNT),
    .B (twelve),
    .GT (x_GT_12)
);

MUX2_other MUX (
    .A (one),
    .B (out_MUL),
    .sel (sel_MUX),
    .out (out_MUX)
);

REG REG(
    .D (out_MUX),
    .LD (ld_REG),
    .clk (clk),
    .Q (out_REG)
);

MUL MUL(
    .x(out_CNT),
    .y(out_REG),
    .z(out_MUL)
);

BUFFER BUF(
    .in (out_REG),
    .OE (OE_BUF),
    .out (product)
);

endmodule