module bitwise_and(A, B, and_output);
	
	input[31:0] A, B; 
	output[31:0] and_output;
	
	generate
	genvar i;
	for (i = 0; i < 32; i = i + 1)
    begin : gen1
		and and_func(and_output[i], A[i], B[i]);	 
    end 
	endgenerate 
	
endmodule 