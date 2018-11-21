module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

   output [31:0] data_result;
   output isNotEqual, isLessThan, overflow;
	
	wire [31:0] add_output, sub_output, and_output, or_output, sll_output, sra_output;
	wire add_overflow, sub_overflow; 
	wire sub, add;
	assign sub = 1'b1;
	assign add = 1'b0;
	
	wire [31:0] dc6, dc7, dc8, dc9, dc10, dc11, dc12, dc13, dc14, dc15, dc16, dc17, dc18, dc19, dc20, dc21, dc22, dc23, dc24, dc25, dc26, dc27, dc28, dc29, dc30, dc31;
      
   /*First: the values for each operation is computed with the input being the two 
	data operands (data_operandA, data_operandB)
	1: add
	2: subtract
	****for subtract, isLessThan and isNotEqual need to be outputs. 
	3: and
	4: or
	5: sll
	6:	sra
	*/	
	
	/*
	module thirty_two_bit_adder(A_in_bits, B_in_bits, sub, thirty_two_bit_sum, c_out, iGT); 
	module SLL(in, shift_amount, shifted_out);
	
	*/
	
	wire isGreaterThanAdd, isGreaterThanSub;
	
	thirty_two_bit_adder addition(data_operandA, data_operandB, add, add_output, add_overflow, isGreaterThanAdd); 
	thirty_two_bit_adder subtraction(data_operandA, data_operandB, sub, sub_output, sub_overflow, isGreaterThanAdd);
	bitwise_and and_func(data_operandA, data_operandB, and_output);
	bitwise_or or_func(data_operandA, data_operandB, or_output);
	SLL shift_logical_left(data_operandA, ctrl_shiftamt, sll_output);
	SRA shift_right_arithmetic(data_operandA, ctrl_shiftamt, sra_output);
	assign dc6 = 32'b0;
	assign dc7 = 32'b0;
	assign dc8 = 32'b0;
	assign  dc9 = 32'b0;
	assign dc10 = 32'b0; 
	assign  dc11 = 32'b0;
	assign dc12 = 32'b0;
	assign  dc13 = 32'b0; 
	assign  dc14 = 32'b0;
	assign  dc15 = 32'b0;
	assign  dc16 = 32'b0; 
	assign  dc17 = 32'b0; 
	assign  dc18 = 32'b0;
	assign  dc19 = 32'b0;
	assign  dc20 = 32'b0; 
	assign  dc21 = 32'b0;
	assign  dc22 = 32'b0;
	assign  dc23 = 32'b0;
	assign  dc24 = 32'b0;
	assign  dc25 = 32'b0;
	assign  dc26 = 32'b0;
	assign  dc27 = 32'b0;
	assign  dc28 = 32'b0;
	assign  dc29 = 32'b0;
	assign  dc30 = 32'b0;
	assign  dc31 = 32'b0; 
	
	
	
	/*Second: each value is put into their respective position into a 32 bit mux. 
	the "don't care" bits of 0 as output are put into the remaining 26 inputs of the mux
	*/
	
	mux_thirty_two mux_for_alu_out(ctrl_ALUopcode, 
	add_output, sub_output, and_output, or_output, sll_output, sra_output, 
	dc6, dc7, dc8, dc9, dc10, dc11, dc12, dc13, dc14, dc15,
	dc16, dc17, dc18, dc19, dc20, dc21, dc22, dc23, 
	dc24, dc25, dc26, dc27, dc28, dc29, dc30, dc31, data_result);
	
	assign overflow = ctrl_ALUopcode[0] ? sub_overflow : add_overflow;
	or or_ine(isNotEqual, sub_output[0], sub_output[1], sub_output[2],
					sub_output[24], sub_output[17], sub_output[10], sub_output[3], 
					sub_output[25], sub_output[18], sub_output[11], sub_output[4],
					sub_output[26], sub_output[19], sub_output[12], sub_output[5],
					sub_output[27], sub_output[20], sub_output[13], sub_output[6],
					sub_output[28], sub_output[21], sub_output[14], sub_output[7],
					sub_output[29], sub_output[22], sub_output[15], sub_output[8],
					sub_output[30], sub_output[23], sub_output[16], sub_output[9], 
					sub_output[31], overflow);
					
	wire not_B31, pos_neg_case;
	not notB(not_B31, data_operandB[31]);
	
	and andneg(pos_neg_case, not_B31, data_operandA[31]);
	or or_ilt( isLessThan, sub_output[31], pos_neg_case);

endmodule
