
`include "projectGlobalParam.v"

module complex_mult(
	clk,
	rst,
	real_i,
    nco_cos,
	imag_i,
    nco_sin,
	valid_i,
	
	res_yimag,
    res_yreal,
	valid_o
);

input 				clk;
input 				rst;
input signed [7:0] 	real_i,nco_cos,nco_sin,imag_i;
input 				valid_i;

output wire signed  [15:0] res_yimag,res_yreal;
output wire         valid_o;

wire                [15:0] res_cosimag,res_cosreal,res_sinimag,res_sinreal;
wire 				mult_val_real, mult_val_imag;

alu_fixed_point MULT_COSREAL(
	.clk		(clk),
	.rst		(rst),
	.op1_i		(nco_cos),
	.op2_i		(real_i),
	.mode_i		(3'd2),
	.valid_i	(valid_i),
	
	.res_o		(res_cosreal),
	.valid_o	(mult_val_real)
);

alu_fixed_point MULT_COSIMAG(
	.clk		(clk),
	.rst		(rst),
	.op1_i		(nco_cos),
	.op2_i		(imag_i),
	.mode_i		(3'd2),
	.valid_i	(valid_i),
	
	.res_o		(res_cosimag),
	.valid_o	()
);

alu_fixed_point MULT_SINREAL(
	.clk		(clk),
	.rst		(rst),
	.op1_i		(nco_sin),
	.op2_i		(real_i),
	.mode_i		(3'd2),
	.valid_i	(valid_i),
	
	.res_o		(res_sinreal),
	.valid_o	(mult_val_imag)
);

alu_fixed_point MULT_SINIMAG(
	.clk		(clk),
	.rst		(rst),
	.op1_i		(nco_sin),
	.op2_i		(imag_i),
	.mode_i		(3'd2),
	.valid_i	(valid_i),
	
	.res_o		(res_sinimag),
	.valid_o	()
);

alu_fixed_point #(.W_in(16), .W_out(16)) YREAL_SUB(
	.clk		(clk),
	.rst		(rst),
	.op1_i		(res_cosreal),
	.op2_i		(res_sinimag),
	.mode_i		(3'd1),
	.valid_i	(mult_val_real),
	
	.res_o		(res_yreal),
	.valid_o	()
);

alu_fixed_point #(.W_in(16), .W_out(16)) YIMAG_ADD(
	.clk		(clk),
	.rst		(rst),
	.op1_i		(res_cosimag),
	.op2_i		(res_sinreal),
	.mode_i		(3'd0),
	.valid_i	(mult_val_imag),
	
	.res_o		(res_yimag),
	.valid_o	(valid_o)
);


endmodule