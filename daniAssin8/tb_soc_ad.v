module tb_sys_ad;

    reg clk;
    reg [11:2] a;
    reg we;
    
    wire we1;
    wire we2;
    wire weM;
    wire [1:0] Rdsel;
    
    integer i, j;
    reg expected_we1, expected_we2, expected_weM;
    reg [1:0] expected_Rdsel;
        
    sys_ad DUT(
        .a      (a),
        .we     (we),
        .we1    (we1),
        .we2    (we2),
        .weM    (weM),
        .Rdsel  (Rdsel)
    );

    task tick;
        begin
            clk = 1'b1; #5;
            clk = 1'b0; #5;
        end
    endtask
    
    initial begin       
        for (j=0; j<2; j=j+1)
        begin
            we = j;
            a = 4'b0000;
            
            for (i=0; i<32'h9ff; i=i+1)
            begin
                // Check results
                if (a == 4'b0000)
                begin
                    expected_we1 = 1'b0;
                    expected_we2 = 1'b0;
                    expected_weM = we;
                    expected_Rdsel = 2'b00;
                end
                else if (a == 4'b1000)
                begin
                    expected_we1 = we;
                    expected_we2 = 1'b0;
                    expected_weM = 1'b0;
                    expected_Rdsel = 2'b10;
                end
                else if (a == 4'b1001)
                begin
                    expected_we1 = 1'b0;
                    expected_we2 = we;
                    expected_weM = 1'b0;
                    expected_Rdsel = 2'b11;
                end
                else
                begin
                    expected_we1 = 1'b0;
                    expected_we2 = 1'b0;
                    expected_weM = 1'b0;
                    expected_Rdsel = 2'b00;
                end   
                
                tick;             
                a = a + 1;
            end
        end
        $finish;
    end    

endmodule