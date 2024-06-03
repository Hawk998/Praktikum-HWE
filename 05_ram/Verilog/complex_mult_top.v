`include "projectGlobalParam.v"

module complex_mult_top(
	clk,
	rst, 
	delta_index_i,
    real_i,
    imag_i,
	valid_i,
	
	real_o,
	imag_o,
    valid_o
);

input 					    clk, rst;
input signed [31:0] 	    delta_index_i; 
input signed [7:0] 			real_i, imag_i;
input 					    valid_i;

output wire signed	[7:0]   real_o, imag_o; 
output wire 				valid_o;

wire signed [7:0]           nco_cos, nco_sin;

nco_top NCO (
    .clk            (clk),
    .rst            (rst),
    .delta_index_i  (delta_index_i),
    .valid_i        (valid_i),

    .real_o         (nco_cos),
    .imag_o         (nco_sin)
);

complex_mult MULT (
    .clk        (clk),
    .rst        (rst),
    .real_i     (real_i),
    .imag_i     (imag_i),
    .nco_cos    (nco_cos),
    .nco_sin    (nco_sin),
    .valid_i    (valid_i),

    .res_yimag  (imag_o),
    .res_yreal  (real_o),    
    .valid_o    (valid_o)
);

endmodule