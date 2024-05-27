`include "projectGlobalParam.v"

module eps_calc(
	clk,
	rst,
	abs2_i,
	power_target_i,
	valid_i,
	
	eps_o,
	valid_o
);

input 					clk;
input 					rst;
input signed [15:0] 	abs2_i, power_target_i;
input 					valid_i;

output wire signed  [31:0] 	eps_o;
output wire valid_o;

wire signed			[15:0] 	eps;
wire 						abs_valid;

alu_fixed_point #(.W_in(16), .W_out(16)) SUB(
	.clk		(clk),
	.rst		(rst),
	.op1_i		(power_target_i),
	.op2_i		(abs2_i),
	.mode_i		(3'd1), // SUB
	.valid_i	(valid_i),
	
	.res_o		(eps),
	.valid_o	(valid_o)
);

assign eps_o = { {10{eps[15]}}, eps, 6'd0 }; // Mult mit kp = 2^-18

endmodule
