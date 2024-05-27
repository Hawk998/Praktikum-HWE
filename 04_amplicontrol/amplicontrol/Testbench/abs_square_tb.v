`include "projectGlobalParam.v"

module abs_square_tb;

reg 				clk;
reg 				rst;
reg signed [7:0] 	op1_i, op2_i;
reg 				valid;



wire signed  [15:0] res_o;
wire 				valid_o;

abs_square DUT(
	.clk		(clk),
	.rst		(rst),
	.real_i		(op1_i),
	.imag_i		(op2_i),
	.valid_i	(valid),
	
	.res_o		(res_o),
	.valid_o	(valid_o)
);

always
	#5 clk = !clk;
	
initial begin
	clk = 0;
	rst = `RST_VAL;
	op1_i = 16;
	op2_i = -5;
	valid = 0;
	
	#100
	rst = !rst;
	valid = 1;
	#10
	valid = 0;
end	


endmodule
