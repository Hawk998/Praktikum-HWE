`include "projectGlobalParam.v"

module abs_square(
	clk,
	rst,
	real_i,
	imag_i,
	valid_i,
	
	res_o,
	valid_o
);

input 				clk;
input 				rst;
input signed [7:0] 	real_i, imag_i;
input 				valid_i;

output wire signed  [15:0] res_o;
output wire valid_o;

wire 				[15:0] real_abs, imag_abs;
wire 				abs_valid;

alu_fixed_point MULTREAL(
	.clk		(clk),
	.rst		(rst),
	.op1_i		(real_i),
	.op2_i		(real_i),
	.mode_i		(3'd2),
	.valid_i	(valid_i),
	
	.res_o		(real_abs),
	.valid_o	(abs_valid)
);

alu_fixed_point MULTIMAG(
	.clk		(clk),
	.rst		(rst),
	.op1_i		(imag_i),
	.op2_i		(imag_i),
	.mode_i		(3'd2),
	.valid_i	(valid_i),
	
	.res_o		(imag_abs),
	.valid_o	()
);


alu_fixed_point #(.W_in(16), .W_out(16)) SUMABS(
	.clk		(clk),
	.rst		(rst),
	.op1_i		(real_abs),
	.op2_i		(imag_abs),
	.mode_i		(3'd0),
	.valid_i	(abs_valid),
	
	.res_o		(res_o),
	.valid_o	(valid_o)
);

endmodule
