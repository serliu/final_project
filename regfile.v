module regfile (
    clock,
    ctrl_writeEnable,
    ctrl_reset,
	 ctrl_writeReg, ctrl_readRegA, ctrl_readRegB,
	 data_writeReg,
    data_readRegA, data_readRegB,
	 reg_3_out, r1_signal
);
	//Inputs 
   input clock, ctrl_writeEnable, ctrl_reset;
   input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
   input [31:0] data_writeReg;
	input r1_signal;
	output [31:0] reg_3_out;

	
	// Outputs
   output [31:0] data_readRegA, data_readRegB;
	
	//Intermediate Values
	wire [31:0] decoded_ctrl_writeReg_bits;
//	wire [31:0] decoded_ctrl_readRegA_bits;
//	wire [31:0] decoded_ctrl_readRegB_bits;
	
	wire [31:0] registers_out [31:0];
	
	/* 1. Take in 5 bits to decide which register to write to and read to
			SYNTAX: decoder(decoded_bits,in_code); */
		
		decoder decoder_writeReg(decoded_ctrl_writeReg_bits, ctrl_writeReg);
//		decoder decoder_readRegA(decoded_ctrl_readRegA_bits, ctrl_readRegA);
	//	decoder decoder_readRegB(decoded_ctrl_readRegB_bits, ctrl_readRegB);
	
	
	/* 2. Take the decoded bit (eg, bit 1) specific to the register (eg, reg 1),
			then AND with ctrl_writeEnable, assign to intermediate wire (wire1).
			This value goes in to the write enable of the register. */
			
	/* 3. For each register, create a register file with all of the inputs
			module register (register_out, register_in, clk, en, clr);
			register_out: intermediate bus for output of register (eg: register_out1)
			register_in: data_write_Reg
			clk: clock
			en: ctrl_writeEnable
			rst:ctrl_reset
			CHECK ALL SPELLING. */
		//module register (register_out, register_in,clk,en,clr);
			
		//register 0 is always 0
		register regs(registers_out[0], 0, clock, 0, ctrl_reset);
		wire [31:0] write_to_r1;
		
		assign write_to_r1 = r1_signal ? 32'd1 : 32'b0;
		
		
		register reg1(registers_out[1], write_to_r1, clock, 1'b1, ctrl_reset);
		
		generate
		genvar i;
		for (i = 2; i < 32; i = i + 1)
		begin : gen_registers
		
			wire intermediate;
			and and_enable(intermediate, ctrl_writeEnable, decoded_ctrl_writeReg_bits[i]); 
			register regs(registers_out[i], data_writeReg, clock, intermediate, ctrl_reset);
				
		end
		endgenerate
		
		assign reg_3_out = registers_out[3];
		
	/* 4. Output of each register goes into 2 32-wide MUX
			For each mux, put in the ctrl_readRegA and ctrl_readRegB
			control bits. The output will go in to readRegA and readRegB,
			MAKE SURE IT CORRESPONDS*/
			
	//mux_thirtytwo five_bit_select,... 32 registers..., output);
			
	// MUX A outputs into readRegA
	
	mux_thirtytwo muxA	(ctrl_readRegA,
								registers_out[0],registers_out[1], registers_out[2],registers_out[3], 
								registers_out[4],registers_out[5], registers_out[6],registers_out[7],
								registers_out[8],registers_out[9], registers_out[10],registers_out[11], 
								registers_out[12],registers_out[13], registers_out[14],registers_out[15], 
								registers_out[16],registers_out[17], registers_out[18],registers_out[19],
								registers_out[20],registers_out[21], registers_out[22],registers_out[23], 
								registers_out[24],registers_out[25], registers_out[26],registers_out[27], 
								registers_out[28],registers_out[29], registers_out[30],registers_out[31],  
								data_readRegA);
	
	// MUX B goes into readRegB
	
	mux_thirtytwo muxB	(ctrl_readRegB,
								registers_out[0],registers_out[1], registers_out[2],registers_out[3], 
								registers_out[4],registers_out[5], registers_out[6],registers_out[7],
								registers_out[8],registers_out[9], registers_out[10],registers_out[11], 
								registers_out[12],registers_out[13], registers_out[14],registers_out[15], 
								registers_out[16],registers_out[17], registers_out[18],registers_out[19],
								registers_out[20],registers_out[21], registers_out[22],registers_out[23], 
								registers_out[24],registers_out[25], registers_out[26],registers_out[27], 
								registers_out[28],registers_out[29], registers_out[30],registers_out[31],  
								data_readRegB);
	
		
endmodule
