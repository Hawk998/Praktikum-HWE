module unsigned_adder_tb;

reg 				clk;
reg 		[7:0] 	op1_i, op2_i;
reg				valid_i;
wire		[7:0] 	sum_o;

unsigned_adder ADD(
	.clk		(clk),
	.op1_i	(op1_i),
	.op2_i	(op2_i),
	.valid_i	(valid_i),
	.sum_o	(sum_o)
);

always 
#5 clk = !clk;

initial begin
clk 	= 1'b0;
op1_i 	= 8'd80;
op2_i 	= 8'd12;
valid_i = 1'b0;
#10
valid_i 	= 1'b1;
#10
valid_i 	= 1'b0;
end


endmodule