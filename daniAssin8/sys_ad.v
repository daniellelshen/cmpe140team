module sys_ad(
        input  wire [11:2] a,
        input  wire       we,
        output reg        we1,
        output reg        we2,
        output reg        weM,
        output reg  [1:0] Rdsel
    );
    
    always @ (*) begin
        casex ({a, 2'b00})
            12'h0xx: begin
                we1 = 1'b0;
                we2 = 1'b0;
                weM = we;
                Rdsel = 2'b00;
            end
            
            12'h80x: begin
                we1 = we;
                we2 = 1'b0;
                weM = 1'b0;
                Rdsel = 2'b10;
            end
            
            12'h90x: begin
                we1 = 1'b0;
                we2 = we;
                weM = 1'b0;
                Rdsel = 2'b11;
            end
            
            default: begin
                we1 = 1'b0;
                we2 = 1'b0;
                weM = 1'b0;
                Rdsel = 2'b00;
            end
         endcase
      end
endmodule
