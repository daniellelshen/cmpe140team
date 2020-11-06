module auxdec (
    	input  wire [1:0]  alu_op,
    	input  wire [5:0]  funct,
    	output wire    	jump2,
    	output wire    	mult_we,
    	output wire [1:0]  result_op,
    	output wire    	shift_op,
    	output wire [2:0]  alu_ctrl
	);
	reg [7:0] ctrl;
	assign {jump2, mult_we, result_op, shift_op, alu_ctrl} = ctrl;
	always @ (alu_op, funct) begin
    	case (alu_op)
        	2'b00: ctrl = 3'b010;      	// ADD
        	2'b01: ctrl = 3'b110;      	// SUB
        	default: case (funct)
            	6'b10_0100: ctrl = 8'b0_0_00_0_000; // AND
            	6'b10_0101: ctrl = 8'b0_0_00_0_001; // OR
            	6'b10_0000: ctrl = 8'b0_0_00_0_010; // ADD
            	6'b10_0010: ctrl = 8'b0_0_00_0_110; // SUB
            	6'b10_1010: ctrl = 8'b0_0_00_0_111; // SLT
            	6'b01_1001: ctrl = 8'b0_1_00_0_000; // MULTU
            	6'b01_0000: ctrl = 8'b0_0_01_0_000; // MFHI
            	6'b01_0010: ctrl = 8'b0_0_10_0_000; // MFLO
            	6'b00_1000: ctrl = 8'b1_0_00_0_000; // JR
            	6'b00_0000: ctrl = 8'b0_0_11_1_000; // SLL
            	6'b00_0010: ctrl = 8'b0_0_11_0_000; // SRL
            	default:	ctrl = 8'bx_x_xx_x_xxx;
        	endcase
    	endcase
	end
endmodule
