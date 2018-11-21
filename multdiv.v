module multdiv(data_operandA, data_operandB, ctrl_MULT, ctrl_DIV, clock, data_result, data_exception, data_resultRDY);
    
	 input [31:0] data_operandA, data_operandB;
    input ctrl_MULT, ctrl_DIV, clock;

    output [31:0] data_result;
    output data_exception, data_resultRDY;
	 
	 wire [31:0] count;
	 
	 wire multRDY, divRDY;
	 
	 wire [64:0] mult_output;
	 wire [31:0] div_output;
	
	 wire m_ovf, div_ovf;
	 
	 
	 // Can keep track of which was the last operation
	 

	 
	multiplier mult0(data_operandA, data_operandB, clock, ctrl_MULT, mult_output, multRDY, m_ovf);
	//divider(dividend, divisor, clock, ctrl_DIV, quotient, divRDY, div_ovf);
	divider div0(data_operandA, data_operandB, clock, ctrl_DIV, div_output, divRDY, div_ovf);
	 	
	//data is ready if count[31] hits 1. 
	  //if count[31] is high, 0 if not.
	  
	 assign data_resultRDY = multRDY || divRDY;
	 //assign data_resultRDY = multRDY ^ divRDY;
	 
	 //assign data_result = multRDY ? mult_output[32:1] : div_output[31:0];
	 assign data_result = multRDY ? mult_output[32:1]: div_output[31:0]; //since out of 65 bits, last is shifted out4
	 
	 assign data_exception = multRDY ? m_ovf: div_ovf;
endmodule


