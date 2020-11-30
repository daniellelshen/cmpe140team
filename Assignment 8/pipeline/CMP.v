module CMP( 
    input [3:0] A, B, 
    output GT 
); 

assign GT = (A > B) ? 1 : 0; 

endmodule 
