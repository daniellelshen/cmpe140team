module shift(
    	input  wire [31:0] num,
    	input  wire [4:0]  amt,
    	input  wire    	op,
    	output reg  [31:0] out    	
	);
	
	always @ (num, amt, op)
	begin
    	if (op)
        	begin
            	out = num << amt;
        	end
    	else
        	begin
            	out = num >> amt;
        	end
	end  
	
endmodule
