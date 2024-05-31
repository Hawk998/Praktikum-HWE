// synopsys translate_off
`timescale 1 ps / 1 ps
`include "projectGlobalParam.v"

module nco_top_tb;


reg 					clk, rst;
reg 		signed 	[31:0] 	delta_index_i;
reg 					valid_i;

wire 	signed	[7:0] real_o, imag_o; 

 nco_top DUT(
	.clk			(clk),
	.rst			(rst), 
	.delta_index_i	(delta_index_i),
	.valid_i		(1'b1),
	
	.real_o			(real_o),
	.imag_o			(imag_o)
);
always
	#5 clk = !clk;

initial begin
	clk = 0;
	rst = `RST_VAL;
	delta_index_i = -32'b00_00000001_0000000000000000000000;
	valid_i  = 1'b1;
	
	#100
	rst = !rst;
end

endmodule

