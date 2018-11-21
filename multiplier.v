module multiplier(

	multiplicand, multiplier1, clock, ctrl_MULT, data_Result, multRDY, m_ovf

);

//-------------------Input, Output-------------------//

	input [31:0] multiplicand, multiplier1;
	input clock;
	input ctrl_MULT;
	output[64:0] data_Result; //last bit is shifted out bit
	output multRDY;
	output m_ovf;
	
	
//-------------------Variables-------------------//
	
	//wire[31:0] c_out_add, c_out_sub;
	wire [64:0] product_intermediate;
	
	//Variables for counter
	wire [31:0] count; 
	
	
	//64 bit register
	wire[64:0] shifted_in_data, shifted_out_data, processed_data;
	
//-------------------Begin Booth's Multiplication-------------------// 
	
	counter mult_counter(clock, ctrl_MULT, count);
	assign multRDY = count[31];
	

	wire [31:0] reg_mcand;
	wire clr; 
	assign clr = 1'b0;
	register reg0(reg_mcand, multiplicand, clock, ctrl_MULT, clr);
	
	//Put the multiplicand on the top of product intermediate, multiplier on bottom
	assign product_intermediate[64:33] = 32'b0;
	assign product_intermediate[32:1] =  multiplier1;
	assign product_intermediate[0] = 1'b0;
	
	//Find which was the last value to be shifted out. Check if all the values should reset
	//assign bit_in = count[0] ? 1'b0: bit_in_int;
	
	
	/*Process the data going through one stage of the multiplier with the value in the register.
	Put that data into the 64 bit register*/
	
	assign shifted_in_data = ctrl_MULT ? product_intermediate : processed_data ;
 
	sixty_four_register product(data_Result, shifted_in_data, clock, 1'b1, clr);
	//sixty_four_register is actually sixty_five_register
		
	stage_mult s2(data_Result, reg_mcand, processed_data);
	
	 //change stage mutiplier to 4 input AND sixty_four reg to sixty 5
	

	//module stage_mult(product_intermediate, multiplicand, bit_shifted_out_in,shifted_stage_out, bit_shifted_out_out);
	
	//assign data_Result = shifted_out_data;
	
	//process the data. 
	//put it back in the register
	check_mult_overflow cmo(data_Result[64:33], m_ovf);
	
	
endmodule 