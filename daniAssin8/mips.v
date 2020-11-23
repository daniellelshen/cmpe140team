module mips (
        input  wire        clk,
        input  wire        rst,
        input  wire [4:0]  ra3,
        input  wire [31:0] instr,
        input  wire [31:0] rd_dm,
        output wire        we_dm,        
        output wire [31:0] pc_current,
        output wire [31:0] result,
        output wire [31:0] wd_dm,
        output wire [31:0] rd3
    );
    
    wire        branch;
    wire        jump;
    wire        jump2;
    wire        reg_dst;
    wire        we_reg;
    wire        alu_src;
    wire        dm2reg;
    wire [1:0]  result_op;
    wire        shift_op;
    wire        wd_sel;
    wire        wa_sel;
    wire        mult_we;
    wire [2:0]  alu_ctrl;

    datapath dp (
            .clk            (clk),
            .rst            (rst),
            .branch         (branch),
            .jump           (jump),
            .jump2          (jump2),
            .reg_dst        (reg_dst),
            .we_reg         (we_reg),
            .alu_src        (alu_src),
            .dm2reg         (dm2reg),
            .result_op      (result_op),
            .shift_op       (shift_op),
            .wd_sel         (wd_sel),
            .wa_sel         (wa_sel),
            .mult_we        (mult_we),
            .alu_ctrl       (alu_ctrl),
            .ra3            (ra3),
            .instr          (instr),
            .rd_dm          (rd_dm),
            .pc_current     (pc_current),
            .wd_dm          (wd_dm),
            .result         (result),
            .rd3            (rd3)
        );

    controlunit cu (
            .opcode         (instr[31:26]),
            .funct          (instr[5:0]),
            .branch         (branch),
            .jump           (jump),
            .jump2          (jump2),
            .reg_dst        (reg_dst),
            .we_reg         (we_reg),
            .alu_src        (alu_src),
            .we_dm          (we_dm),
            .dm2reg         (dm2reg),
            .result_op      (result_op),
            .shift_op       (shift_op),
            .wd_sel         (wd_sel),
            .wa_sel         (wa_sel),
            .mult_we        (mult_we),
            .alu_ctrl       (alu_ctrl)
        );

endmodule