`include "projectGlobalParam.v"

module alu_fixed_point_tb;

reg 				clk;
reg 				rst;
reg signed [7:0] 	op1_i, op2_i;
reg 				valid_i;
reg [2:0] 			mode_i;


wire signed  [15:0] res_o;
wire 				valid_o;

alu_fixed_point DUT(
	.clk			(clk),
	.rst			(rst),
	.op1_i			(op1_i),
	.op2_i			(op2_i),
	.mode_i			(mode_i),
	.valid_i		(valid_i),
	
	.res_o			(res_o),
	.valid_o		(valid_o)
);

always
	#5 clk = !clk;
	
initial begin
	clk = 0;
	rst = 0;
	op1_i = 16;
	op2_i = 2;
	mode_i = 5;
	valid_i = 0;
	
	#100
	rst = 1;
end	


endmodule
