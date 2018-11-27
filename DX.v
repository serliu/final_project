module DX (FD_PC, data_readRegA, data_readRegB, FD_IR, imm_sx, target_sx, control, clock, en, reset , flush, 
	        DX_PC, DX_A, DX_B, DX_IR, DX_imm_sx, DX_target_sx, DX_control);
			  
			  
	//probably need to implement some sort of stall or flush logic 
   //enable? should clr be flush logic? 
	//FLUSH probably comes out of comparison of comparator. if condition IS true, then flush.
			//then, decide to take the PC + N command IF condition is true (flush = true). 
			//else if flush!= true, pc +1 and no flush	
			
				
	//flush is different than reset because write 0s to each register (check to see een if PC is flushed, don't think so)
	//module register (register_out,register_in,clk,en,clr);
	
	input [31:0] FD_PC, data_readRegA, data_readRegB, FD_IR, imm_sx, target_sx, control;
	input clock, en, reset, flush;
	output [31:0] DX_PC, DX_A, DX_B, DX_IR, DX_imm_sx, DX_target_sx, DX_control; 
	wire clr;
	assign clr = reset;

	//if flush, then flush
	
	
	wire [31:0] A_in, control_in, PC_in, B_in, IR_in, imm_in, target_in;
	assign A_in = flush ? 32'b0 : data_readRegA;
	assign B_in = flush ? 32'b0 : data_readRegB;
	assign control_in = flush ? 32'b0 : control;
	assign PC_in = flush ? 32'b0 : FD_PC;
	
	assign IR_in = flush ? 32'b0 : FD_IR;
	assign imm_in = flush ? 32'b0 : imm_sx;
	assign target_in = flush ? 32'b0 : target_sx;
	
	
	
	
	register DXcontrol(DX_control, control_in, clock, en, clr);
	register FDPC(DX_PC, PC_in, clock, en, reset);
	register DXA(DX_A, A_in, clock, en, clr);
	register DXB(DX_B, B_in, clock, en, clr);
	register DXIR(DX_IR, IR_in, clock, en, clr);
	register DXimm(DX_imm_sx, imm_in, clock, en, clr);
	register DXtarget(DX_target_sx,target_in, clock, en, clr);
	


endmodule 