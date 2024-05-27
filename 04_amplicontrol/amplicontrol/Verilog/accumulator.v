`include "projectGlobalParam.v"

module accumulator(
	clk,
	rst,
	eps_i,
	valid_i,
	
	c_o
);

input 					clk;
input 					rst;
input signed [31:0] 	eps_i;
input 					valid_i;

output wire  [15:0] 	c_o;

reg signed [31:0] 	eps_r;
reg					valid_r;

reg signed [31:0] 	accu_register_r, accu_register_temp;

/// sequential part starts here
always @(posedge clk) begin
	if(rst == `RST_VAL) begin
		accu_register_r <= {8'd1, 24'd0};
		eps_r 			<= 'd0;
		valid_r			<= 'd0;
	end
	else begin
		accu_register_r <= accu_register_temp;
		eps_r 			<= eps_i;
		valid_r			<= valid_i;
	end
end

/// combinational part 
always @ (*) begin
	accu_register_temp	= accu_register_r;
	if(valid_r) begin
		accu_register_temp = accu_register_r + eps_r;
	end
end

assign c_o = (accu_register_r[31:16] == 16'd0) ? 16'd1 : accu_register_r[31:16];

endmodule
