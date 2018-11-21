module stage_mult (product_intermediate, multiplicand, shifted_stage_out);
						

//-------------------Input, Output-------------------//		
	 input[64:0] product_intermediate;
	 input[31:0] multiplicand;
	 output[64:0] shifted_stage_out;
	 
//-------------------Variables-------------------//
	 wire [64:0] preshifted_bits0;
	 wire[31:0] multiplicand_added, multiplicand_subbed;
	 wire ilta, ilts;
	 wire add, sub;
	 assign add = 1'b0;
	 assign sub = 1'b1;
	 
	 wire c_out_add, c_out_sub;
	 
	 
//-------------------Begin processing for stage n of multiply-------------------//
	 
	 thirty_two_bit_adder add_mcand_0(product_intermediate[64:33], 
												 multiplicand, add , multiplicand_added, c_out_add, ilta); 
	 thirty_two_bit_adder sub_mcand_0(product_intermediate[64:33], 
												 multiplicand, sub , multiplicand_subbed, c_out_sub, ilts); 
	
	 /*  Use a four bit mux to determine what the preshifted [63:32] bits are
	  Inputs to mux are
	  LSB of the product_intermediate and the bit_shifted_out. 
	  00: product_intermediate[63:32]
	  01: multiplicand_added -- sum of multiplicand and product_intermediate[63:32]
	  10: multiplicand_subbed-- difference of product_intermediate[63:32] and multiplicand
	  11: just product_intermediate[63:32]
	  */
	 mux_four mux_0(product_intermediate[1],
							product_intermediate[0],
							product_intermediate[64:33],
							multiplicand_added, 
							multiplicand_subbed,
							product_intermediate[64:33],
							preshifted_bits0[64:33]);
							
	 assign preshifted_bits0[32:0] = product_intermediate[32:0];
	
	 //shift right arithmetic one. save the bit shifted out. change one bit_sra to 65.
	 one_bit_sra shift0(preshifted_bits0, shifted_stage_out);
	
	
endmodule 