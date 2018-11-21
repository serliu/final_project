module bitwise_or(A, B, or_output);
	
	input[31:0] A, B; 
	output[31:0] or_output;
	
	generate
	genvar i;
	for (i = 0; i < 32; i = i + 1)
    begin : gen1
		or or_func(or_output[i], A[i], B[i]);	 
    end 
	endgenerate 

endmodule 