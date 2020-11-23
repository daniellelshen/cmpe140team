module hex_to_7seg(number, s);     
output reg [6:0] s;     
input [3:0] number;     
reg [6:0] s;     
always @ (number)     
begin // BCD to 7-segment decoding         
case (number) // s0 - s6 are active low             
4'd0: s = 7'b1000000;

            4'd1: s = 7'b1111001;

            4'd2: s = 7'b0100100;

            4'd3: s = 7'b0110000;

            4'd4: s = 7'b0011000;

            4'd5: s = 7'b0010010;

            4'd6: s = 7'b0000010;

            4'd7: s = 7'b1111000;

            4'd8: s = 7'b0000000;

            4'd9: s = 7'b0010000;

            4'ha: s = 7'b0000010;

            4'hb: s = 7'b1100000;

            4'hc: s = 7'b1110010;

            4'hd: s = 7'b1100010;

            4'he: s = 7'b0010000;

            4'hf: s = 7'b0111000;             

            default: s = 7'b1111111;   
endcase     
end endmodule 