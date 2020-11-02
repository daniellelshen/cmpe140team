module multu(
    	input  	[31:0] a,
    	input  	[31:0] b,
    	input  	mult_we,
    	output reg [31:0] mfhi,
    	output reg [31:0] mflo
	);
	
	reg [63:0] result;
	
	always @ (a, b, mult_we) begin
    	if (mult_we) begin
        	result = a * b;
        	mfhi = result[63:32];
        	mflo = result[31:0];
    	end
	end
	
	
endmodule
