module SLL(
	in, shift_amount, shifted_out
);

	input[31:0] in; 
	input [4:0] shift_amount;
	output[31:0] shifted_out;
	
	wire [31:0] mux_sixteen_shifted, mux_eight_shifted, mux_four_shifted, mux_two_shifted, mux_one_shifted;
	
	wire[31:0] sixteen_out, eight_out, four_out, two_out;
	
	
	//Take the input, and shift it LEFT by 16 bits, padding the void space with 0s.
	
	assign mux_sixteen_shifted[31:16] = in[15:0];
	
	assign mux_sixteen_shifted[15:0] = 16'b0;
	
	//the original input and the mux_sixteen_shifted need to be chosen between using the shift_amount[4]
	
	assign sixteen_out = shift_amount[4] ? mux_sixteen_shifted : in;
	
	//Take the sixteen_out and shift it by eight. then select b/w sixteen_out and mux_eight_shifted 
	assign mux_eight_shifted[31:8] = sixteen_out[23:0];
	
	assign mux_eight_shifted[7:0] = 8'b0;
	
	assign eight_out = shift_amount[3] ? mux_eight_shifted : sixteen_out;
	
	
	assign mux_four_shifted[31:4] = eight_out[27:0];
	
	assign mux_four_shifted[3:0] = 4'b0;
	
	assign four_out = shift_amount[2] ? mux_four_shifted : eight_out;
	
	
	assign mux_two_shifted[31:2] = four_out[29:0];
	
	assign mux_two_shifted[1:0] = 2'b0;
	
	assign two_out = shift_amount[1] ? mux_two_shifted : four_out;
	

	assign mux_one_shifted[31:1] = two_out[30:0];
	
	assign mux_one_shifted[0] = 1'b0;
	
	assign shifted_out = shift_amount[0] ? mux_one_shifted : two_out;
	
	
endmodule 