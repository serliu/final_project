module register (register_out,register_in,clk,en,clr);
	input [31:0] register_in;
	input clk, en, clr;
	output [31:0] register_out;
	
	//wire [31:0] out; 
	


	/* Input each data bit of register_in along with clk, en, clr
		to its specific DFF to store. 
		The DFF will take care of the write enable and clr. 
		Assign output of each DFFE to the wire array out. 
	*/
		//dffe_ref(q, d, clk, en, clr);
	dffe_ref dffe0(register_out[0], register_in[0], clk, en, clr);
	dffe_ref dffe1(register_out[1], register_in[1], clk, en, clr);
	dffe_ref dffe2(register_out[2], register_in[2], clk, en, clr);
	dffe_ref dffe3(register_out[3], register_in[3], clk, en, clr);
	dffe_ref dffe4(register_out[4], register_in[4], clk, en, clr);
	
	dffe_ref dffe5(register_out[5], register_in[5], clk, en, clr);
	dffe_ref dffe6(register_out[6], register_in[6], clk, en, clr);
	dffe_ref dffe7(register_out[7], register_in[7], clk, en, clr);
	dffe_ref dffe8(register_out[8], register_in[8], clk, en, clr);
	
	dffe_ref dffe9(register_out[9], register_in[9], clk, en, clr);
	dffe_ref dffe10(register_out[10], register_in[10], clk, en, clr);
	dffe_ref dffe11(register_out[11], register_in[11], clk, en, clr);
	dffe_ref dffe12(register_out[12], register_in[12], clk, en, clr);
	
	dffe_ref dffe13(register_out[13], register_in[13], clk, en, clr);
	dffe_ref dffe14(register_out[14], register_in[14], clk, en, clr);
	dffe_ref dffe15(register_out[15], register_in[15], clk, en, clr);
	dffe_ref dffe16(register_out[16], register_in[16], clk, en, clr);
	
	dffe_ref dffe17(register_out[17], register_in[17], clk, en, clr);
	dffe_ref dffe18(register_out[18], register_in[18], clk, en, clr);
	dffe_ref dffe19(register_out[19], register_in[19], clk, en, clr);
	dffe_ref dffe20(register_out[20], register_in[20], clk, en, clr);
	
	dffe_ref dffe21(register_out[21], register_in[21], clk, en, clr);
	dffe_ref dffe22(register_out[22], register_in[22], clk, en, clr);
	dffe_ref dffe23(register_out[23], register_in[23], clk, en, clr);
	dffe_ref dffe24(register_out[24], register_in[24], clk, en, clr);
	
	dffe_ref dffe25(register_out[25], register_in[25], clk, en, clr);
	dffe_ref dffe26(register_out[26], register_in[26], clk, en, clr);
	dffe_ref dffe27(register_out[27], register_in[27], clk, en, clr);
	dffe_ref dffe28(register_out[28], register_in[28], clk, en, clr);
	
	dffe_ref dffe29(register_out[29], register_in[29], clk, en, clr);
	dffe_ref dffe30(register_out[30], register_in[30], clk, en, clr);
	dffe_ref dffe31(register_out[31], register_in[31], clk, en, clr);
	
endmodule 