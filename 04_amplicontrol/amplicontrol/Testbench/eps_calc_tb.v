`include "projectGlobalParam.v"

module eps_calc_tb;

reg 					clk;
reg 					rst;
reg signed [15:0] 		abs2_i, power_target_i;
reg 					valid_i;

wire signed  [31:0] 	res_o;
wire valid_o;

eps_calc DUT(
	.clk			(clk),
	.rst			(rst),
	.abs2_i			(abs2_i),
	.power_target_i		(power_target_i),
	.valid_i		(valid_i),
	
	.eps_o			(res_o),
	.valid_o		(valid_o)
);

always
	#5 clk = !clk;
	
initial begin
	clk 			= 0;
	rst 			= `RST_VAL;
	abs2_i 			= 3176;
	power_target_i 		= 4096;
	valid_i 			= 0;
	
	#100
	rst 			= !rst;
	valid_i 			= 1;
	#10
	valid_i 			= 0;
end	


endmodule
