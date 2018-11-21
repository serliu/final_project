module one_bit_sra(
	A, out
);

	//Checked, works

	input[64:0] A;
	output signed[64:0] out;
	
	
	
	assign out = $signed(A) >>> 1; 



endmodule 