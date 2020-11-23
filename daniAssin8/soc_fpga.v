module soc_fpga( 
    input  wire         clk, 
    input  wire         rst,
    input  wire         button,
    input  wire  [4:0]  switches,
    output wire         dispSe,
    output wire         factErr,
    output wire  [7:0]  LEDOUT,
    output wire  [3:0]  LEDSEL
);

    wire        clk_5KHz, clk_pb;
    wire [7:0]  LED3,LED2,LED1,LED0;
    
    wire [3:0]  display3, display2, display1, display0;
    wire [31:0] pc_current;
    wire [31:0] instr;
    wire [31:0] result;
    wire [31:0] wd_dm;
    wire [31:0] we_dm;
    wire [31:0] gpI1, gpI2;
    wire [31:0] gpO1, gpO2;
    wire [31:0] rd, ra3;
    wire [31:0] dispData;
    wire [31:0] DONT_USE;
    
    assign gpO1[0] = factErr;
    assign gpO1[1] = dispSe;
    assign gpI2 = gpO1;
    
    clk_gen clk_gen (
            .clk50MHz           (clk),
            .rst                (rst),
            .clk_4sec           (DONT_USE),
            .clk_5KHz           (clk_5KHz)
    );
   
    button_debouncer button_debouncer (
            .clk                (clk_5KHz),
            .button             (button),
            .debounced_button   (clk_pb)
    );
         
    soc soc (
            .clk        (clk_5KHz),
            .rst        (rst),
            .ra3        (ra3),
            .gpI1       ({27'b0, switches[4:0]}),
            .gpI2       (gpI2),
            .we_dm      (we_dm),
            .gpO1       (gpO1),
            .gpO2       (gpO2),
            .pc_current (pc_current),
            .instr      (instr),
            .result     (result),
            .wd_dm      (wd_dm),
            .rd3        (DONT_USE)        
    );
    
    HILO_MUX hilo (
        .HI_dig3    (gpO2[31:28]),
        .HI_dig2    (gpO2[27:24]),
        .HI_dig1    (gpO2[23:20]),
        .HI_dig0    (gpO2[19:16]),
        .LO_dig3    (gpO2[15:12]),
        .LO_dig2    (gpO2[11:8]),
        .LO_dig1    (gpO2[7:4]),
        .LO_dig0    (gpO2[3:0]),
        .HILO_sel   (switches[4]),
        .HW_dig3    (display3),
        .HW_dig2    (display2),
        .HW_dig1    (display1),
        .HW_dig0    (display0)
    );

    hex_to_7seg hex3 (
           .HEX                (display3),
           .s                  (LED3)
        );

    hex_to_7seg hex2 (
           .HEX                (display2),
           .s                  (LED2)
        );

    hex_to_7seg hex1 (
           .HEX                (display1),
           .s                  (LED1)
        );

    hex_to_7seg hex0 (
           .HEX                (display0),
           .s                  (LED0)
        );

    led_mux led_mux (
           .clk                (clk_5KHz),
           .rst                (rst),
           .LED3               (LED3),
           .LED2               (LED2),
           .LED1               (LED1),
           .LED0               (LED0),
           .LEDSEL             (LEDSEL),
           .LEDOUT             (LEDOUT)
        );
    
endmodule
