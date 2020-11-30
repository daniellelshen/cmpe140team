module BUFFER (
    input [31:0] in,
    input wire OE,
    output [31:0] out
);

assign out = (OE == 1'b0) ? 32'bz : in;

endmodule