`include "projectGlobalParam.v"

module amp_regler_top(
	clk,
	rst,
	real_i,
	imag_i,
	valid_i,
	
	real_o,
	imag_o,
	valid_o
);

input 						clk;
input 						rst;
input signed [7:0] 			real_i, imag_i;
input 						valid_i;

output wire signed  [7:0] 	real_o, imag_o;
output wire 				valid_o;

wire signed [15:0] 			abs2;
wire 						valid_abs;
wire signed [31:0] 			eps;
wire 						valid_eps;
wire  		[15:0] 			c;
wire signed [15:0] 			real_scale_input, imag_scale_input;
wire signed [15:0] 			real_output, imag_output;

assign real_o 				= real_output[15:8];
assign imag_o 				= imag_output[15:8];
assign real_scale_input 	= {{8{real_i[7]}}, real_i};
assign imag_scale_input 	= {{8{imag_i[7]}}, imag_i};

alu_fixed_point #(.W_in(16), .W_out(16)) MULTREAL(
	.clk		(clk),
	.rst		(rst),
	.op1_i		(real_scale_input),
	.op2_i		(c),
	.mode_i		(3'd2),
	.valid_i	(valid_i),
	
	.res_o		(real_output),
	.valid_o	(valid_o)
);

alu_fixed_point #(.W_in(16), .W_out(16)) MULTIMAG(
	.clk		(clk),
	.rst		(rst),
	.op1_i		(imag_scale_input),
	.op2_i		(c),
	.mode_i		(3'd2),
	.valid_i	(),
	
	.res_o		(imag_output),
	.valid_o	()
);

 abs_square ABS(
	.clk		(clk),
	.rst		(rst),
	.real_i		(real_o),
	.imag_i		(imag_o),
	.valid_i	(valid_o),
	
	.res_o		(abs2),
	.valid_o	(valid_abs)
);

eps_calc EPS(
	.clk			(clk),
	.rst			(rst),
	.abs2_i			(abs2),
	.power_target_i	(16'd4096),
	.valid_i		(valid_abs),
	
	.eps_o			(eps),
	.valid_o		(valid_eps)
);

accumulator ACCU(
	.clk			(clk),
	.rst			(rst),
	.eps_i			(eps),
	.valid_i		(valid_eps),
	
	.c_o			(c)
);

endmodule
