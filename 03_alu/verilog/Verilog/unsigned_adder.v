module unsigned_adder(
	clk,
	op1_i,
	op2_i,
	valid_i,
	sum_o
	);

input 		clk;
input 		[7:0] 	op1_i, op2_i;
input		valid_i;
output reg	[7:0] 	sum_o;

reg 		valid_r;
reg 		[7:0] op1_r, op2_r;
reg 		[7:0] op1_save_r, op2_save_r;
reg 		[7:0] op1_save_temp, op2_save_temp;

always @ (posedge clk) begin
	op1_r 		<= op1_i;
	op2_r 		<= op2_i;
	op1_save_r 	<= op1_save_temp;
	op2_save_r 	<= op2_save_temp;
	valid_r 	<= valid_i;
end

always @ (*) begin
op1_save_temp = op1_save_r;
op2_save_temp = op2_save_r;
	if(valid_r) begin
         op1_save_temp = op1_r;
         op2_save_temp = op2_r;
	end
sum_o = op1_save_r + op2_save_r;
end


endmodule

