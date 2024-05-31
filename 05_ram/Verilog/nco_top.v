`include "projectGlobalParam.v"

module nco_top(
	clk,
	rst, 
	delta_index_i,
	valid_i,
	
	real_o,
	imag_o
);

input 					clk, rst;
input 		signed 	[31:0] 	delta_index_i;
input 					valid_i;

output reg 	signed	[7:0] real_o, imag_o; 

wire signed 	[31:0] 	lut_index;
wire signed 	[31:0] 	lut_sine;
assign lut_sine = lut_index - (32'b01_00000000_0000000000000000000000);

wire signed [7:0] cosine, sine;

reg [1:0]	quadrant_r, quadrant_r1;

nco_index_increment INDXINCR(
	.clk			(clk),
	.rst			(rst), 
	.delta_index_i	(delta_index_i),
	.valid_i		(valid_i),
	
	.lut_index_o	(lut_index)
);

nco_ram  #(.MIF("cos_ram.mif")) COS (
	.clock		(clk),
	.data		('d0),
	.rdaddress	(lut_index[29:22]),
	.wraddress	('d0),
	.wren		(1'b0),
	.q			(cosine)
	);
	
nco_ram #(.MIF("sin_ram.mif")) SIN(
	.clock		(clk),
	.data		('d0),
	.rdaddress	(lut_sine[29:22]),
	.wraddress	('d0),
	.wren		(1'b0),
	.q			(sine)
	);

/// sequential part starts here
always @(posedge clk) begin
	if(rst == `RST_VAL) begin
		quadrant_r 		<= 'd0;
		quadrant_r1		<= 'd0;
	end
	else begin
		quadrant_r 		<= lut_index[31:30];
		quadrant_r1		<= quadrant_r;
	end
end

/// combinational part: Quadrant Mapping
always @ (*) begin
	real_o = cosine;
	imag_o = sine;
	if(quadrant_r1 == 2'd1) begin
		real_o = -sine;
		imag_o = cosine;
	end
	else if(quadrant_r1 == 2'd2) begin
		real_o = -cosine;
		imag_o = -sine;
	end
	else if(quadrant_r1 == 2'd3) begin
		real_o = sine;
		imag_o = -cosine;
	end
end

endmodule

