module decoder(

	decoded_bits,
	in_code

);

	input[4:0] in_code;
	output[31:0] decoded_bits;
	
	wire A, B, C, D, E;
	
	assign A = in_code[4];
	assign B = in_code[3];
	assign C = in_code[2];
	assign D = in_code[1];
	assign E = in_code[0];
	
	wire notA, notB, notC, notD, notE;
	
	not not0 (notA, A);
	not not1 (notB, B);
	not not2 (notC, C);
	not not3 (notD, D);
	not not4 (notE, E);
	
	and and0(decoded_bits[0], notA, notB, notC, notD, notE);
	and and1(decoded_bits[1], notA, notB, notC, notD, E);
	and and2(decoded_bits[2], notA, notB, notC, D, notE);
	and and3(decoded_bits[3], notA, notB, notC, D, E);
	
	and and4(decoded_bits[4], notA, notB, C, notD, notE);
	and and5(decoded_bits[5], notA, notB, C, notD, E);
	and and6(decoded_bits[6], notA, notB, C, D, notE);
	and and7(decoded_bits[7], notA, notB, C, D, E);

	and and8(decoded_bits[8], notA, B, notC, notD, notE);
	and and9(decoded_bits[9], notA, B, notC, notD, E);
	and and10(decoded_bits[10], notA, B, notC, D, notE);
	and and11(decoded_bits[11], notA, B, notC, D, E);
	
	and and12(decoded_bits[12], notA, B, C, notD, notE);
	and and13(decoded_bits[13], notA, B, C, notD, E);
	and and14(decoded_bits[14], notA, B, C, D, notE);
	and and15(decoded_bits[15], notA, B, C, D, E);
	//----------------------------------------------//
	and and16(decoded_bits[16], A, notB, notC, notD, notE);
	and and17(decoded_bits[17], A, notB, notC, notD, E);
	and and18(decoded_bits[18], A, notB, notC, D, notE);
	and and19(decoded_bits[19], A, notB, notC, D, E);
	
	and and20(decoded_bits[20], A, notB, C, notD, notE);
	and and21(decoded_bits[21], A, notB, C, notD, E);
	and and22(decoded_bits[22], A, notB, C, D, notE);
	and and23(decoded_bits[23], A, notB, C, D, E);

	and and24(decoded_bits[24], A, B, notC, notD, notE);
	and and25(decoded_bits[25], A, B, notC, notD, E);
	and and26(decoded_bits[26], A, B, notC, D, notE);
	and and27(decoded_bits[27], A, B, notC, D, E);
	
	and and28(decoded_bits[28], A, B, C, notD, notE);
	and and29(decoded_bits[29], A, B, C, notD, E);
	and and30(decoded_bits[30], A, B, C, D, notE);
	and and31(decoded_bits[31], A, B, C, D, E);



endmodule 