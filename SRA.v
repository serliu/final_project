module SRA(in, shift_amount, shifted_out);


	input [31:0] in; 
	input [4:0] shift_amount;
	output[31:0] shifted_out;
	
	wire [31:0] mux_sixteen_shifted, mux_eight_shifted, mux_four_shifted, mux_two_shifted, mux_one_shifted;
	
	wire[31:0] sixteen_out, eight_out, four_out, two_out;
	
	
	//Take the input, and shift it right by 16 bits, padding the void space with MSB of input.
	
	assign mux_sixteen_shifted[15:0] = in[31:16];
	
	assign mux_sixteen_shifted[31] = in[31];
	assign mux_sixteen_shifted[30] = in[31];
	assign mux_sixteen_shifted[29] = in[31];
	assign mux_sixteen_shifted[28] = in[31];
	assign mux_sixteen_shifted[27] = in[31];
	assign mux_sixteen_shifted[26] = in[31];
	assign mux_sixteen_shifted[25] = in[31];
	assign mux_sixteen_shifted[24] = in[31];
	assign mux_sixteen_shifted[23] = in[31];
	assign mux_sixteen_shifted[22] = in[31];
	assign mux_sixteen_shifted[21] = in[31];
	assign mux_sixteen_shifted[20] = in[31];
	assign mux_sixteen_shifted[19] = in[31];
	assign mux_sixteen_shifted[18] = in[31];
	assign mux_sixteen_shifted[17] = in[31];
	assign mux_sixteen_shifted[16] = in[31];
	
	assign sixteen_out = shift_amount[4] ? mux_sixteen_shifted : in;
	
	//eight
	assign mux_eight_shifted[23:0] = sixteen_out[31:8];
	
	assign mux_eight_shifted[31] = in[31];
	assign mux_eight_shifted[30] = in[31];
	assign mux_eight_shifted[29] = in[31];
	assign mux_eight_shifted[28] = in[31];
	assign mux_eight_shifted[27] = in[31];
	assign mux_eight_shifted[26] = in[31];
	assign mux_eight_shifted[25] = in[31];
	assign mux_eight_shifted[24] = in[31];
	
	assign eight_out = shift_amount[3] ? mux_eight_shifted : sixteen_out;
	
	//four
	assign mux_four_shifted[27:0] = eight_out[31:4];
	
	assign mux_four_shifted[31] = in[31];
	assign mux_four_shifted[30] = in[31];
	assign mux_four_shifted[29] = in[31];
	assign mux_four_shifted[28] = in[31];
	
	assign four_out = shift_amount[2] ? mux_four_shifted : eight_out;
	
	
	assign mux_two_shifted[29:0] = four_out[31:2];
	
	assign mux_two_shifted[31] = in[31];
	assign mux_two_shifted[30] = in[31];
	
	assign two_out = shift_amount[1] ? mux_two_shifted : four_out;
	

	assign mux_one_shifted[30:0] = two_out[31:1];
	
	assign mux_one_shifted[31] = in[31];
	
	assign shifted_out = shift_amount[0] ? mux_one_shifted : two_out;
	
	
	


endmodule 