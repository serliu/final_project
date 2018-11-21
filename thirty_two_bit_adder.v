module thirty_two_bit_adder( 

	A_in_bits, B_in_bits, sub, thirty_two_bit_sum, c_out, isGreaterThan
	
); 
	
	
	input [31:0] A_in_bits, B_in_bits;
	input sub;
	output [31:0] thirty_two_bit_sum;
	output c_out; 
	output isGreaterThan;
	wire isLessThan;
	
	wire[3:0] block_carry_out;
	wire [31:0]  B_bits;
	wire [31:0] xor_bits_sub;
	
	xor xor_for_sub0(B_bits[0], B_in_bits[0], sub);
	xor xor_for_sub1(B_bits[1], B_in_bits[1], sub);
	xor xor_for_sub2(B_bits[2], B_in_bits[2], sub);
	xor xor_for_sub3(B_bits[3], B_in_bits[3], sub);
	xor xor_for_sub4(B_bits[4], B_in_bits[4], sub);
	xor xor_for_sub5(B_bits[5], B_in_bits[5], sub);
	xor xor_for_sub6(B_bits[6], B_in_bits[6], sub);
	xor xor_for_sub7(B_bits[7], B_in_bits[7], sub);
	
	xor xor_for_sub8(B_bits[8], B_in_bits[8], sub);
	xor xor_for_sub9(B_bits[9], B_in_bits[9], sub);
	xor xor_for_sub10(B_bits[10], B_in_bits[10], sub);
	xor xor_for_sub11(B_bits[11], B_in_bits[11], sub);
	xor xor_for_sub12(B_bits[12], B_in_bits[12], sub);
	xor xor_for_sub13(B_bits[13], B_in_bits[13], sub);
	xor xor_for_sub14(B_bits[14], B_in_bits[14], sub);
	xor xor_for_sub15(B_bits[15], B_in_bits[15], sub);
	
	xor xor_for_sub16(B_bits[16], B_in_bits[16], sub);
	xor xor_for_sub17(B_bits[17], B_in_bits[17], sub);
	xor xor_for_sub18(B_bits[18], B_in_bits[18], sub);
	xor xor_for_sub19(B_bits[19], B_in_bits[19], sub);
	xor xor_for_sub20(B_bits[20], B_in_bits[20], sub);
	xor xor_for_sub21(B_bits[21], B_in_bits[21], sub);
	xor xor_for_sub22(B_bits[22], B_in_bits[22], sub);
	xor xor_for_sub23(B_bits[23], B_in_bits[23], sub);
	
	xor xor_for_sub24(B_bits[24], B_in_bits[24], sub);
	xor xor_for_sub25(B_bits[25], B_in_bits[25], sub);
	xor xor_for_sub26(B_bits[26], B_in_bits[26], sub);
	xor xor_for_sub27(B_bits[27], B_in_bits[27], sub);
	xor xor_for_sub28(B_bits[28], B_in_bits[28], sub);
	xor xor_for_sub29(B_bits[29], B_in_bits[29], sub);
	xor xor_for_sub30(B_bits[30], B_in_bits[30], sub);
	xor xor_for_sub31(B_bits[31], B_in_bits[31], sub);
	
	
	eight_bit_adder eba_0(A_in_bits[7:0], B_bits[7:0], sub, thirty_two_bit_sum[7:0], block_carry_out[0]);
	
	eight_bit_adder eba_1(A_in_bits[15:8], B_bits[15:8], block_carry_out[0], thirty_two_bit_sum[15:8], block_carry_out[1]);
	
	eight_bit_adder eba_2(A_in_bits[23:16], B_bits[23:16], block_carry_out[1], thirty_two_bit_sum[23:16], block_carry_out[2]);
	
	eight_bit_adder eba_3(A_in_bits[31:24], B_bits[31:24], block_carry_out[2], thirty_two_bit_sum[31:24], block_carry_out[3]);
	
	wire check_for_both_positive, not_a32, not_b32;
	wire check_for_both_negative_add, check_for_both_negative_sub;
	wire thirty_two_bit_sum_not; 
	wire add;
	not not_sub(add, sub);
	
	not not32(thirty_two_bit_sum_not, thirty_two_bit_sum[31]);
	not nota(not_a32, A_in_bits[31]);
	not notb(not_b32, B_in_bits[31]);
	
	and and_for_overflow_positive(check_for_both_positive, not_a32, not_b32, thirty_two_bit_sum[31], add );
	and and_for_overflow_negative_add(check_for_both_negative_add, A_in_bits[31],B_in_bits[31], thirty_two_bit_sum_not, add);
	and and_for_overflow_negative_sub(check_for_both_negative_sub, A_in_bits[31], B_bits[31], thirty_two_bit_sum_not, sub);
	
	or or_for_c_out(c_out, check_for_both_positive, check_for_both_negative_add, check_for_both_negative_sub);
	
	//For is less than
	wire not_B31, pos_neg_case;
	not notB(not_B31, B_in_bits[31]);
	
	and andneg(pos_neg_case, not_B31, A_in_bits[31], sub);
	or or_ilt(isLessThan, thirty_two_bit_sum[31], pos_neg_case);
	not notLess (isGreaterThan, isLessThan);
	
	
	
endmodule 