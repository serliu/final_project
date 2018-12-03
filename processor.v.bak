/**
 * READ THIS DESCRIPTION!
 *
 * The processor takes in several inputs from a skeleton file.
 *
 * Inputs
 * clock: this is the clock for your processor at 50 MHz
 * reset: we should be able to assert a reset to start your pc from 0 (sync or
 * async is fine)
 *
 * Imem: input data from imem
 * Dmem: input data from dmem
 * Regfile: input data from regfile
 *
 * Outputs
 * Imem: output control signals to interface with imem
 * Dmem: output control signals and data to interface with dmem
 * Regfile: output control signals and data to interface with regfile
 *
 * Notes
 *
 * Ultimately, your processor will be tested by subsituting a master skeleton, imem, dmem, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file acts as a small wrapper around your processor for this purpose.
 *
 * You will need to figure out how to instantiate two memory elements, called
 * "syncram," in Quartus: one for imem and one for dmem. Each should take in a
 * 12-bit address and allow for storing a 32-bit value at each address. Each
 * should have a single clock.
 *
 * Each memory element should have a corresponding .mif file that initializes
 * the memory element to certain value on start up. These should be named
 * imem.mif and dmem.mif respectively.
 *
 * Importantly, these .mif files should be placed at the top level, i.e. there
 * should be an imem.mif and a dmem.mif at the same level as process.v. You
 * should figure out how to point your generated imem.v and dmem.v files at
 * these MIF files.
 *
 * imem
 * Inputs:  12-bit address, 1-bit clock enable, and a clock
 * Outputs: 32-bit instruction
 *
 * dmem
 * Inputs:  12-bit address, 1-bit clock, 32-bit data, 1-bit write enable
 * Outputs: 32-bit data at the given address
 *
 */
 
 
 /*TODO: imem, dmem, rstatus, PC confusion
			stalls, flushing 
			DX, XM, MW stages,
			wm bypassing*/
			
//When to flush and stall? where do i put this logic?
	//do I flush just the FD DX pipeline???
	



module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for regfile
    ctrl_writeReg,                  // O: Register to write to in regfile
    ctrl_readRegA,                  // O: Register to read from port A of regfile
    ctrl_readRegB,                  // O: Register to read from port B of regfile
    data_writeReg,                  // O: Data to write to for regfile
    data_readRegA,                  // I: Data from port A of regfile
    data_readRegB, flush, DX_control, control                 // I: Data from port B of regfile
	 
	 
	 //Begin delete later--for testing
	// instruction,
	// alu_output_testing,
	
	//DX_PC, DX_A, DX_B, DX_IR, DX_imm_sx, DX_target_sx, DX_control
	// XM_PC, XM_IR, XM_target_sx, XM_output, XM_control, XM_B_data, XM_old_PC
	//MW_old_PC, MW_IR, MW_control, MW_output, MW_dmem, MW_target_sx
	
);


//TO DELETE: 
//input[31:0] instruction;
//output[31:0] alu_output_testing;
//END TO DELETE



    // Control signals
    input clock, reset;

    // Imem
    output [11:0] address_imem;
    input [31:0] q_imem;

    // Dmem
    output [11:0] address_dmem;
    output [31:0] data;
    output wren;
    input [31:0] q_dmem;

    // Regfile
    output ctrl_writeEnable;
    output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    output [31:0] data_writeReg;
    input [31:0] data_readRegA, data_readRegB;
	 
	 
	 /*Start with the register for the PC to F
	   Start the counter at 0 then add 1 each time*/
		
	 wire [31:0] PC_current_out; //comes out of PC register
	 wire [31:0] PC_calculated; //calculated from jump and branch stuff, come in from the x stage
	 wire [31:0] PC_plus_1; // plus 1 every time to get to new insn
	 wire [31:0] FD_PC; //PC from FD pipelines
	wire [31:0] PC_to_pass;
	 
	 
	 output flush;
	 wire en;
	 assign en = 1'b1;  

	 
	 //-----------------ASSIGNING WIRES-------------------//
	 //Fetch stage wires
	 wire [31:0] instruction; 
	 //Decode stage wires
	 wire [31:0] DX_PC, DX_A, DX_B, DX_IR, DX_imm_sx, DX_target_sx;
	 output [31:0] DX_control;
	// output [31:0] DX_PC, DX_A, DX_B, DX_IR, DX_imm_sx, DX_target_sx, DX_control;
	 //Execute stage wires
	 wire [31:0] alu_A, alu_B, alu_op, alu_op_others, data_result; 
	 wire isNotEqual, isLessThan, alu_overflow;
	 
	 wire [31:0] A_bypass_data_MX, A_bypass_data_WX, B_bypass_data_MX, B_bypass_data_WX, A_bypass_data, B_bypass_data, B_data; 
	 wire A_bypass_MX_sel, A_bypass_WX_sel, B_bypass_MX_sel, B_bypass_WX_sel, needs_bypassing_A, needs_bypassing_B;
	 
	 //output[31:0] XM_PC, XM_IR, XM_target_sx, XM_output, XM_control, XM_B_data, XM_old_PC;
	 wire[31:0] XM_PC, XM_IR, XM_target_sx, XM_output, XM_control, XM_B_data, XM_old_PC, XM_flush;
	 //Memory stage wires
	 
	 wire [31:0] MW_old_PC, MW_IR, MW_control, MW_output, MW_dmem, MW_target_sx;
	// output[31:0] MW_old_PC, MW_IR, MW_control, MW_output, MW_dmem, MW_target_sx;
	 //Writeback stage wires
	 wire [31:0] data_decision1, data_decision2;
	 
	 wire[4:0] ctrl_decision;
	 wire IGT_trashbits, cout_trashbits;
	 	 
	 /*-----------------FETCH STAGE----------------------- 
		1. Fetch instruction from Instruction Memory using the PC 
		2. Figure out which registers to read and write from 
		3. Write to FD
	 */
	 
	 //q_imem now goes to FD register
	
	 
	 register PC(PC_current_out, PC_calculated, ~clock, 1'b1, reset);
	 
	 register PC_FD1(FD_PC, PC_current_out, clock, 1'b1, reset );
	 
	 assign address_imem = PC_current_out[11:0]; //outputs this instruction so that it can be fetched from insn mem
	 
	 thirty_two_bit_adder PCadder(PC_current_out, 32'h00000001, 1'b0, PC_plus_1, cout_trashbits, IGT_trashbits);

	 

	 assign instruction = q_imem;
	 
	 
	 wire[31:0] FD_IR;
	 
	 wire [31:0] FD_in;
	 assign FD_in = flush ? 32'b0 : instruction; 
	 
	 register FD_IR1(FD_IR, FD_in, clock, 1'b1, reset); //write the instruction to PC_IR register of the PC pipeline reg
	 
	 //put load stalls here? 
		
	 
	 /*-----------------DECODE STAGE-----------------------
		1. Registers Fetch (from reg file) and Instruction Decode
		2. Write to DX register
	 */
	 
		
		//SEE ABOUT FLUSHING
		
	  
	 
	 //modify regfile so that it includes rstatus
		/*IN control[31:0]:
		0. is r-type --implicitly, has rt
		1. has rs -- r-type, i-type
		2. has immediate - sw, lw, bne, blt, addi --> select immediate in execute stage
		3. writes to pc - blt,bne, jr, bex, jal, j
		4. writes to a reg -- has rd to write, r-type, lw, addi, jal, setx
		5. writes to memory --> sw dmem WE
		6. 
		7. writes to rstatus --> R type, setx
		8. reads rstatus --> bex
		9. read rd instead of rt --> sw, jr, blt, bne
		10. choose between data B and alu output, jr or sw
		11. use multdiv output --> control[15] || control[23]
		....
		12. is add
		13. is addi
		14. is sub
		15. is mul 00110
		16. is lw 
		17. is branch -- READ rd instead of rt, SELECT PC execute
		18. is jal
		19. is jr -- for setting pc = rd data (in output of xm register)
		20. is j1 -jal, j, bex, setx --> has target
		21. is j
		22. is setx 
		23. is div 00111
		24. is bne
		25. is blt
		*/

	output [31:0] control; 
	control_unit controls(FD_IR, control);
	
	//Read data from regfile-externally
	// regfile registers(clock, 1'b1, reset, WB_write_register, rs, rt, WB_write_register_data, A, B); //TODO: check the write enable, create WB_write_register
	assign ctrl_readRegA = control[8] ? 5'b11110 : FD_IR[21:17]; //read rstatus or rs 
   assign ctrl_readRegB = control[9] ? FD_IR[26:22] : FD_IR[16:12]; //read rt or rd?
	
	
	//Identify immediate and target, sign extend both
	wire[31:0] imm_sx, target_sx;
	
	assign imm_sx[16:0] = FD_IR[16:0];
	assign imm_sx[31:17] = FD_IR[16] ? 15'b111111111111111 : 15'b0;
	
	assign target_sx[26:0] = FD_IR[26:0];
	assign target_sx[31:27] =  5'b0;

		
	 /*TO BE WRITTEN TO DX REGISTERS
		1. PC --> FD_PC in, DX_PC out
		2. 32 A BITS FROM REG (data_readRegA) --> output = DX_A
		3. 32 B BITS FROM REG (data_readRegB) --> output = DX_B
		4. instruction with rs, rt, rd, shamt, ALU_op -- everything, 
		since will need to know rs and rt in decode stage for byp,
		need shamt and aluop in case of r type insn
		FD_IR in, DX_IR out
		5. immediate sign extended --> imm_sx in, DX_imm_sx out
		6. target sign extended --> target_sx in, DX_target_sx
		7. control bus--> control in,  DX_control out
	
	 */
	 
	 
	 DX dx1(FD_PC, data_readRegA, data_readRegB, FD_IR, imm_sx, target_sx, control, clock, en, reset, flush,
	        DX_PC, DX_A, DX_B, DX_IR, DX_imm_sx, DX_target_sx, DX_control); 
	 
	  /*-----------------EXECUTE STAGE-----------------------
		0. Must mux between inputs to the ALU 
		1. Depending on insn... 
			a. R type: perform ALU op
				muldiv too
			b. I type: perform ALU op with immediate
				if branch, need to compare before ALU stuff
			c. J type: Calculate the memory address-adding offset to PC
		2. Write to XM register
		*/
		
		/* rd = instruction[26:22];
		   rs = instruction[21:17]; 
			rt = instruction[16:12];
			alu_op [6:2]
			shamt [11:7]*/
		
	
	 
	 
	 //MUXES FOR SELECTING A, INCLUDING BYPASSING
	// TODO:  check this logic
	 assign A_bypass_data_MX = XM_output; 
	 assign A_bypass_data_WX = data_writeReg;
	 
	 assign A_bypass_MX_sel = &(~(DX_IR[21:17] ^ XM_IR[26:22])) && XM_control[4]; //check this logic, IF dx.rs == xm.rd --> xm bypass
	 assign A_bypass_WX_sel = &(~(DX_IR[21:17] ^ MW_IR[26:22])) && MW_control[4]; //and check if this value is to be written to a reg
	 assign needs_bypassing_A = A_bypass_MX_sel || A_bypass_WX_sel; 
	 assign A_bypass_data =  A_bypass_MX_sel ? A_bypass_data_MX : A_bypass_data_WX ;
	 assign alu_A = needs_bypassing_A ? A_bypass_data: DX_A;
	
	 
	 
	 //MUXES FOR SELECTING B, INCLUDING BYPASSING AND immediate stuff
	 
	 assign B_bypass_data_MX = XM_output; 
	 assign B_bypass_data_WX = data_writeReg;
	 
	 assign B_bypass_MX_sel = &(~(DX_IR[16:12] ^ XM_IR[26:22])) && XM_control[4]; //check this logic, IF dx.rs == xm.rd --> xm bypass
	 assign B_bypass_WX_sel = &(~(DX_IR[16:12] ^ MW_IR[26:22])) && MW_control[4];
	 
	 assign needs_bypassing_B = B_bypass_MX_sel || B_bypass_WX_sel; 
	 assign B_bypass_data =  B_bypass_MX_sel ? B_bypass_data_MX : B_bypass_data_WX ;
	 assign B_data = needs_bypassing_B ? B_bypass_data : DX_B ;
	 assign alu_B = DX_control[2] ? DX_imm_sx : B_data; //immediate
	 
	//Mux between alu opcode and 00000
	assign alu_op_others = DX_control[0] ? DX_IR[6:2] : 5'b00000;
	assign alu_op = DX_control[17] ? 5'b00001 : alu_op_others; //if it's a branch, use sub to compare 
	
	
	wire[31:0] multdiv_output;
	wire multdiv_exception, multdiv_RDY;
	 
	 
	 multdiv multdiver(alu_A, alu_B, DX_control[15], DX_control[23], clock, multdiv_output, multdiv_exception, multdiv_RDY); 
	 
	 alu aluer(alu_A, alu_B, alu_op, DX_IR[11:7] , data_result, isNotEqual, isLessThan, alu_overflow);
	 
	 //ALU TESTING: DELETE THIS
	 
	 //assign alu_output_testing = data_result;
	 
	 
	 //END DELETE

	 //CALCULATE OVERFLOW HERE
	 wire ovf_data_add, ovf_data_addi, ovf_data_sub, ovf_data_mul, ovf_data_div; 
	 wire[31:0] rstatus_data, rstatus_int1, rstatus_int2, rstatus_int3, rstatus_int4;
	 wire[31:0] new_instruction_rd; 
	 wire overflow_exists;
	 assign overflow_exists = alu_overflow;
	 
	 assign ovf_data_add = DX_control[12] && alu_overflow;
	 assign ovf_data_addi = DX_control[13] && alu_overflow;
	 assign ovf_data_sub = DX_control[14] && alu_overflow; 
	 assign ovf_data_mul = multdiv_exception && DX_control[15];
	 assign ovf_data_div = multdiv_exception && DX_control[23];
	
	 
	 assign rstatus_int1 = ovf_data_add ? 32'h00000001 : 32'b0 ;
	 assign rstatus_int2 = ovf_data_addi ? 32'h00000002 : rstatus_int1;
	 assign rstatus_int3 = ovf_data_sub ? 32'h00000003 : rstatus_int2;
	 assign rstatus_data = ovf_data_mul ? 32'h00000004 : rstatus_int3;
	 
	 //Make a new instruction destination register for writeback IF rstatus instead of RD
	 assign new_instruction_rd[31:27] = DX_IR[31:27];
	 assign new_instruction_rd[26:22] = overflow_exists ? 5'b11110: DX_IR[26:22];
	 assign new_instruction_rd[21:0] = DX_IR[21:0];
	 

	 //must mux between alu output OR the B data operand OR the mul div output for input to xm register
	 wire [31:0]  X_output, X1_output;
	 assign X1_output = DX_control[11] ? multdiv_output : data_result; //use output from multdiv? 
	 assign X_output = overflow_exists ? rstatus_data : X1_output ; //output for rstatus

	 //FIGURE OUT FLUSH STUFF AND PC CALCULATIONS HERE
	 wire branch_taken, target_jumps, jr_insn, bex_taken; 
	 assign branch_taken = (isLessThan && DX_control[25]) || (isNotEqual && DX_control[24]);
	 
	 assign bex_taken = (~|alu_A[31:0] && DX_control[8]); //if bex AND rstatus is 0, PC=T
	 assign target_jumps = DX_control[21] || DX_control[18] || bex_taken; //j, jal, bex, PC = T
	 
	 assign jr_insn = DX_control[19]; //PC = rd, which in this case is operand B 
	 assign flush = branch_taken || target_jumps || jr_insn || bex_taken;
	 
	 //Calculate PC = PC+N for branches
	 wire[31:0] PC_branch;
	 wire IGT_trashbits1, cout_trashbits1;
	 thirty_two_bit_adder PCadder_branch(DX_PC, DX_imm_sx, 1'b0, PC_branch, cout_trashbits1, IGT_trashbits1);

	 /*ASSIGN PC_to_pass to XM register: 
	   target_jumps --> PC= DX_target_sx
		jr --> PC = rd --> PC = DX_B
		branch --> PC = PC + N
	 */ 
	
	 wire [31:0] intermediate_PC, intermediate_2_PC; 
	 assign intermediate_PC = branch_taken ? PC_branch: DX_PC; 
	 assign intermediate_2_PC = target_jumps ? DX_target_sx: intermediate_PC;
	 assign PC_to_pass = jr_insn ? DX_B : intermediate_2_PC;
	 
		/*To be written to the XM latch
		0. old PC for jal
		1. PC calculated or maybe not
		2. instruction 
		3. sx target
		4. output (of alu or md)
		5. control bus
		6. Data rd (which is alu_b)
		*note: don't need immediate anymore!
		*/
	 assign PC_calculated = flush ? PC_to_pass: PC_plus_1;
		
	 XM xm1(DX_PC, PC_to_pass, new_instruction_rd, DX_target_sx, DX_control, X_output, DX_B, flush,clock, en, reset,
				 XM_old_PC, XM_PC, XM_IR, XM_target_sx, XM_control, XM_output, XM_B_data); 
	   
	 
	  /*-----------------MEMORY STAGE-----------------------
		1. Write the data into the Data Memory 
			a. for stores and loads
			b. everything else waits
		2. Write to MW register	
	 */
	 //assign pc, which could be a calculated pc or a regular pc
	 //make control[31] = to the XM stage flush bit
	// assign PC_calculated = XM_control[31]? XM_PC: PC_plus_1;
	 
	 //wm bypassing--> if MW.RD == XM.RD(sw)
	 wire[31:0] WM_bypass_data;
	 assign WM_bypass_data = data_writeReg; //data from MW stage (after mux) 
	 wire WM_bypass;
	 assign WM_bypass = &(~(MW_IR[26:22] ^ XM_IR[26:22])) && XM_control[5] && MW_control[4]; //rd = rs and rd writes to a register and curr insn is sw  
	 
	 assign wren = XM_control[5];
	 assign data = WM_bypass ? WM_bypass_data : XM_B_data; //SHOULD BE RD if this is a sw 
	 assign address_dmem = XM_output[11:0];  //a memory address for sw or lw
	 
	 //q_dmem will now have the data for lw!!
	 /* TO be written to MW stage
	 1. XM_output 
	 2. q_imem
	 3. instruction (for rd) 
	 4. control
	 5. target_sx
	  DO I NEED PC?? 
	 
	 */
	 
	 MW mw1(XM_old_PC, XM_IR, XM_control, XM_output, q_dmem, XM_target_sx, clock, en, reset,
				 MW_old_PC, MW_IR, MW_control, MW_output, MW_dmem, MW_target_sx); 
	 
	  /*---------------+--WRITEBACK STAGE-----------------------
		1. Write the ALU output back to the register file for
			a. R type and I type
			b. stores and loads do nothing. and J type does not write to regs
			WRITE BACK TO REGISTER: CONTROL[4] 
	 */
	
	   
		assign ctrl_writeEnable = MW_control[4]; // || multdiv_RDY;             // O: Write enable for regfile
		
		
		
		assign ctrl_decision = MW_control[22] ? 5'b11110 : MW_IR[26:22];  //rstatus or rd? setx 
		assign ctrl_writeReg = MW_control[18] ? 5'b11111 : ctrl_decision;		// if it's jal, r31 write
		
		
		/*decide bw which data to write to reg:
		LW: MW_dmem
		JAL: MW_old_pc ...maybe it's XM_old_PC???? bc pc+1
		setx: MW_target_sx
		other: MW_output
		*/
		
		assign data_decision1 = MW_control[16] ? MW_dmem: MW_output; //is lw? switch bw alu output or mem output
		assign data_decision2 = MW_control[18] ? MW_old_PC: data_decision1; //is jal? COULD BE XM_old_PC...b/c PC+1
		assign data_writeReg = MW_control[22] ? MW_target_sx : data_decision2; //is setx
		
		
		

		
endmodule
