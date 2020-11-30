module CNT ( 
    input [31:0] D, 
    input clk, en, ld, 
    output reg [31:0] Q 
); 

always @ (posedge clk) begin 
    if (!en) Q <= Q; 
    else if (ld) Q <= D; 
    else Q <= Q-1; 
end 

endmodule 
