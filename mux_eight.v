module mux_eight (
	three_bit_select,
	register0,
	register1,
	register2,
	register3,
	
	register4,
	register5,
	register6,
	register7,
	
	register_out
);

	input [2:0] three_bit_select;
	input [31:0] register0, register1, register2, register3;
	input [31:0] register4, register5, register6, register7;
	
	output [31:0] register_out;
	
	wire [31:0] bracket0, bracket1;
	wire [1:0] two_of_three_bit_select; 
	
	assign two_of_three_bit_select[0] = three_bit_select[0];
	assign two_of_three_bit_select[1] = three_bit_select[1];
	
	
	mux_four mux_four_zero(two_of_three_bit_select[1],two_of_three_bit_select[0], register0, register1, register2, register3, bracket0);
	mux_four mux_four_one(two_of_three_bit_select[1],two_of_three_bit_select[0], register4, register5, register6, register7, bracket1);
	
	assign register_out = three_bit_select[2] ? bracket1: bracket0 ;
	
endmodule 