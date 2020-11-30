module REG ( 
    input [31:0] D, 
    input LD, clk, 
    output [31:0] Q 
); 

reg [31:0] data; 

always @ (posedge clk) begin 
    if(LD) data <= D; 
    else data = data; 
end 

assign Q = data; 

endmodule 
