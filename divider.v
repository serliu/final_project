module divider(dividend, divisor, clock, ctrl_DIV, quotient, divRDY, div_ovf);
		
		input [31:0] dividend, divisor;
		input clock, ctrl_DIV;
		output[31:0] quotient;
			output div_ovf;
			output divRDY;
		
		wire[31:0] remains, quo, divis; 
		wire[31:0] remainder_out, quotient_out, divisor_out;
		wire en, clr;
		assign en = 1'b1;
		assign clr = 1'b0;
		wire [31:0] sub_output;
		wire sub;
		assign sub = 1'b1;
		wire sub_ovf;
		wire iGT;
		
		
		wire [31:0] count;
		
		//start counter
		
		counter mult_counter(clock, ctrl_DIV, count);
		assign divRDY = count[31];
		
		wire [31:0] remainder_chosen, quotient_chosen_shifted , divisor_shifted, quotient_chosen;
	
		
		//need ternary for initialization of registers
		assign remains = ctrl_DIV ? dividend: remainder_chosen ;
		assign quo =  ctrl_DIV ? 32'b0: quotient_chosen_shifted;
		assign divis = ctrl_DIV ? divisor: divisor_shifted;
		register remainder(remainder_out, remains, clock, en, clr  );
		register quotient1(quotient_out, quo, clock, en, clr  ); 
		register divisor1(divisor_out, divis, clock, en, clr  );
		
		thirty_two_bit_adder subs(remainder_out, divisor_out, sub, sub_output, sub_ovf, iGT);
		
		assign remainder_chosen = iGT ? sub_output: remainder_out; 
		//assign remainder_chosen_shifted = remainder_chosen << 1;
		//don't shift remainder
		
		assign quotient_chosen = quotient_out << 1;
		assign quotient_chosen_shifted[31:1] = quotient_chosen[31:1];
		assign quotient_chosen_shifted[0] = iGT;
		
		assign divisor_shifted = divisor_out >> 1;
		
		assign quotient = quotient_out;
		
		assign div_ovf = &(~divisor[31:0]); //if divisor is all 0 
		

endmodule 