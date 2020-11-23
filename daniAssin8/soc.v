module soc(
        input  wire         clk,
        input  wire         rst,
        input  wire [4:0]   ra3,
        input  wire [31:0]  gpI1, gpI2,
        output wire [31:0]  pc_current,  
        output wire [31:0]  rd3,               
        output wire [31:0]  gpO1, gpO2,
        output wire [31:0]  rd
    );
    
    wire [31:0] instr;
    wire        we_dm;
    wire [31:0] result, wd_dm;
    wire        we1, we2, weM;
    wire [1:0]  Rdsel;
    wire [31:0] factorial_data, gpio_data;
    wire [31:0] rd_dm;
   
    imem imem (
        .a          (pc_current[7:2]),
        .y          (instr)
    );
    
    mips mips (
        .clk        (clk),
        .rst        (rst),
        .ra3        (ra3),
        .instr      (instr),
        .rd_dm      (rd),
        .we_dm      (we_dm),
        .pc_current (pc_current),
        .result     (result),
        .wd_dm      (wd_dm),
        .rd3        (rd3)        
    );
    
    sys_ad Decoder(
        .a          (result[11:2]),
        .we         (we_dm),
        .we1        (we1),
        .we2        (we2),
        .weM        (weM),
        .Rdsel      (Rdsel)        
    );

    dmem dmem (
        .clk        (clk),
        .we         (weM),
        .a          (result[7:2]),
        .d          (wd_dm),
        .q          (rd_dm)
    );    
    
    fact_top Factorial(
        .clk        (clk),
        .rst        (rst),
        .A          (result[3:2]),
        .WE         (we1),
        .WD         (wd_dm[3:0]),
        .RD         (factorial_data)
    );
    
    gpio_top GPIO (
        .clk        (clk),
        .rst        (rst),
        .a          (result[3:2]),
        .we         (we2),
        .wd         (wd_dm),
        .gpI1       (gpI1),
        .gpI2       (gpI2),
        .rd         (gpio_data),
        .gpO1       (gpO1),
        .gpO2       (gpO2)
    );
   
   mux4 # (32) soc_mux (
        .sel (Rdsel),
        .a (rd_dm),
        .b (rd_dm),
        .c (factorial_data),
        .d (gpio_data),
        .y (rd)
   );
    
endmodule
