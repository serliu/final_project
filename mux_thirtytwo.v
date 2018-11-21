module mux_thirtytwo 
(
	five_bit_select,
	register0, register1, register2, register3,
	register4, register5, register6, register7,
	register8, register9, register10, register11,
	register12, register13, register14, register15,
	
	register16, register17, register18, register19,
	register20, register21, register22, register23,
	register24, register25, register26, register27,
	register28, register29, register30, register31,
	
	register_out
);
	
	//4 eight mux to 1 four mux
	input [4:0] five_bit_select;
	input [31:0] register0, register1, register2, register3,
					 register4, register5, register6, register7,
					 register8, register9, register10, register11,
					 register12, register13, register14, register15,
	
					 register16, register17, register18, register19,
					 register20, register21, register22, register23,
					 register24, register25, register26, register27,
					 register28, register29, register30, register31;
	output [31:0] register_out;
	
	//SPLIT the select bits
	wire[2:0] three_of_five_bits;
	assign three_of_five_bits[0] = five_bit_select[0];
	assign three_of_five_bits[1] = five_bit_select[1];
	assign three_of_five_bits[2] = five_bit_select[2];
	
	
	wire[1:0] two_of_five_bits;
	assign two_of_five_bits[0] = five_bit_select[3];
	assign two_of_five_bits[1] = five_bit_select[4];
	
	//Intermediate registers
	
	wire [31:0] bracket0, bracket1, bracket2, bracket3;
	
	mux_eight mux_eight_zero(three_of_five_bits, register0, register1, register2, register3,
									 register4, register5, register6, register7, bracket0);
	mux_eight mux_eight_one(three_of_five_bits, register8, register9, register10, register11,
									 register12, register13, register14, register15, bracket1);
	mux_eight mux_eight_two(three_of_five_bits, register16, register17, register18, register19,
									 register20, register21, register22, register23, bracket2);
	mux_eight mux_eight_three(three_of_five_bits, register24, register25, register26, register27,
									 register28, register29, register30, register31, bracket3);
									 
	
	mux_four mux_results(two_of_five_bits[1], two_of_five_bits[0] , bracket0, bracket1, bracket2, bracket3, register_out);
	
	

endmodule




