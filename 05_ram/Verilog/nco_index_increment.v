`include "projectGlobalParam.v"

module nco_index_increment(
	clk,
	rst, 
	delta_index_i,
	valid_i,
	
	lut_index_o
);

input 					clk, rst;
input signed 	[31:0] 	delta_index_i;
input 					valid_i;

output reg signed 	[31:0] 	lut_index_o;

reg signed 		[31:0] 	accu_reg_r, accu_reg_temp;
reg signed 		[31:0] 	delta_index_r;
reg 					valid_r;

/// sequential part starts here
always @(posedge clk) begin
	if(rst == `RST_VAL) begin
		accu_reg_r 		<= 'd0;
		delta_index_r	<= 'd0;
		valid_r 		<= 'd0;
	end
	else begin
		accu_reg_r 		<= accu_reg_temp;
		delta_index_r	<= delta_index_i;
		valid_r 		<= valid_i;
	end
end

/// combinational part 
always @ (*) begin
	lut_index_o 		= accu_reg_r;
	accu_reg_temp		= accu_reg_r;
	if(valid_r) begin
		accu_reg_temp 	= accu_reg_r + delta_index_r;
	end
end

endmodule

