module eight_bit_adder (

	 A_bits, B_bits, carry_in, eight_bit_sum, c_out

);
	
	input [7:0] A_bits, B_bits;
	input carry_in;
	output [7:0] eight_bit_sum;
	output c_out;
	
	wire[7:0] carry_outs;
	wire[7:0] g;
	wire[7:0] p;
	
	//Calculate ps and gs
	
	and and0(g[0], A_bits[0], B_bits[0]);
	and and1(g[1], A_bits[1], B_bits[1]);
	and and2(g[2], A_bits[2], B_bits[2]);
	and and3(g[3], A_bits[3], B_bits[3]);
	and and4(g[4], A_bits[4], B_bits[4]);
	and and5(g[5], A_bits[5], B_bits[5]);
	and and6(g[6], A_bits[6], B_bits[6]);
	and and7(g[7], A_bits[7], B_bits[7]);
	
	xor xor0(p[0], A_bits[0], B_bits[0]);
	xor xor1(p[1], A_bits[1], B_bits[1]);
	xor xor2(p[2], A_bits[2], B_bits[2]);
	xor xor3(p[3], A_bits[3], B_bits[3]);
	xor xor4(p[4], A_bits[4], B_bits[4]);
	xor xor5(p[5], A_bits[5], B_bits[5]);
	xor xor6(p[6], A_bits[6], B_bits[6]);
	xor xor7(p[7], A_bits[7], B_bits[7]);
	
	//for subtracting is xor with sub bit and carry in of 1
	//calculate carry_outs[0] (carry out of A0 & B0) 
	//c0=g0+p0*cin
	
	wire c0_and_result;
	and andc0 (c0_and_result, p[0], carry_in);
	or orc0 (carry_outs[0], c0_and_result, g[0]);
	
	wire c1_and_result;
	and andc1 (c1_and_result, p[1], carry_outs[0]);
	or orc1 (carry_outs[1], c1_and_result, g[1]);
	
	wire c2_and_result;
	and andc2 (c2_and_result, p[2], carry_outs[1]);
	or orc2 (carry_outs[2], c2_and_result, g[2]);
	
	wire c3_and_result;
	and andc3 (c3_and_result, p[3], carry_outs[2]);
	or orc3 (carry_outs[3], c3_and_result, g[3]);
	
	wire c4_and_result;
	and andc4 (c4_and_result, p[4], carry_outs[3]);
	or orc4 (carry_outs[4], c4_and_result, g[4]);
	
	wire c5_and_result;
	and andc5 (c5_and_result, p[5], carry_outs[4]);
	or orc5 (carry_outs[5], c5_and_result, g[5]);
	
	wire c6_and_result;
	and andc6 (c6_and_result, p[6], carry_outs[5]);
	or orc6 (carry_outs[6], c6_and_result, g[6]);
	
	wire c7_and_result;
	and andc7 (c7_and_result, p[7], carry_outs[6]);
	or orc7 (carry_outs[7], c7_and_result, g[7]);
	
	//calculate sum 
	
	xor xor_sum0(eight_bit_sum[0], p[0], carry_in);
	xor xor_sum1(eight_bit_sum[1], p[1], carry_outs[0] );
	xor xor_sum2(eight_bit_sum[2], p[2], carry_outs[1] );
	xor xor_sum3(eight_bit_sum[3], p[3], carry_outs[2] );
	xor xor_sum4(eight_bit_sum[4], p[4], carry_outs[3] );
	xor xor_sum5(eight_bit_sum[5], p[5], carry_outs[4] );
	xor xor_sum6(eight_bit_sum[6], p[6], carry_outs[5] );
	xor xor_sum7(eight_bit_sum[7], p[7], carry_outs[6] );
	
	assign c_out = carry_outs[7];
	//see if this works as 4 8 bit adders, if not do hierarchical and calculate P0 = p7*p6*....p0
	// G0 = g7 +p7*g6.....p7p6p5p4p3p2p1g0
	
	
endmodule 