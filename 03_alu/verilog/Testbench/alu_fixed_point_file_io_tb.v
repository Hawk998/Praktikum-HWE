`include "projectGlobalParam.v"

module alu_fixed_point_file_io_tb;

integer operands_input_fd, operands_output_fd;

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
	operands_input_fd		= $fopen("operands_input.dat");
	operands_output_fd 		= $fopen("operands_output.dat");
	clk = 0;
	rst = `RST_VAL;
	op1_i = 16;
	op2_i = 2;
	mode_i = 0;
	valid_i = 0;
	
	#100
	rst = !(`RST_VAL);
	
	#10
	valid_i = 1'b1;
	#10
	valid_i = 1'b0;
	
end	

always @ (posedge clk) begin
#1
	if(!(`RST_VAL)) begin
		if(valid_o) begin
			$fwrite(operands_output_fd,"%d\n",res_o);
		end
		
		if(valid_i) begin
			$fwrite(operands_input_fd,"%d\n",mode_i);
			$fwrite(operands_input_fd,"%d\n",op1_i);
			$fwrite(operands_input_fd,"%d\n",op2_i);
		end
		
	end
end


endmodule
