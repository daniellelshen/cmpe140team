module cu_factorial(
        input       clk,
        input       go,
        input       err,
        input       gt,
        output  reg load_cnt,
        output  reg en,
        output  reg load_reg,
        output  reg sel1,
        output  reg sel2,
        output  reg done,
        output  reg reset,
        
        output reg [1:0] CS
    );
    
    parameter S0 = 2'b00,
              S1 = 2'b01,
              S2 = 2'b10,
              S3 = 2'b11;
    
    reg [1:0] NS;
    
    initial 
    begin
        CS = S0;
        NS = S0;
    end
    
    always @ (posedge clk) 
    begin
        CS <= NS;
    end
    
    always @ (CS, go, err, gt) 
    begin
        case(CS)
            S0: NS = (go == 1'b1 && err == 1'b0) ? S1 : S0;
            S1: NS = S2;
            S2: NS = (gt == 1'b1) ? S2 : S3;
            S3: NS = S0; //TODO: Make it loop twice to display high and low digits
            default: NS = (go == 1'b1 && err == 1'b0) ? S1 : S0;
        endcase
    end
    
    always @ (CS) 
    begin
        case(CS)
            S0:
            begin
                load_cnt  <= 0; 
                en <= 0;
                load_reg <= 0;
                sel1 <= 1;
                sel2 <= 1;
                done  <= 0;
                reset <= 1;
            end
            S1:
            begin
                load_cnt  <= 1; 
                en <= 0;
                load_reg <= 1;
                sel1 <= 1;
                sel2 <= 1;
                done  <= 0;
                reset <= 0;
            end
            S2:
            begin
                load_cnt  <= 0; 
                en <= 1;
                load_reg <= 1;
                sel1 <= 0;
                sel2 <= 1;
                done  <= 0;
                reset <= 0;
            end
            S3:
            begin
                load_cnt <= 0; 
                en <= 1;
                load_reg <= 0;
                sel1 <= 1;
                sel2 <= 0;
                done  <= 1;
                reset <= 0;
            end    
            default: begin
                load_cnt  = 0; 
                en = 0;
                load_reg = 0;
                sel1 = 1;
                sel2 = 1;
                done  = 0;
                reset = 1;
            end      
        endcase
    end
endmodule