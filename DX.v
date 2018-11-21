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
	assign clr = reset || flush;

	//if flush, then flush
	
	
	
	
	
	register FDPC(DX_PC, FD_PC, clock, en, reset);
	register DXA(DX_A, data_readRegA, clock, en, clr);
	register DXB(DX_B, data_readRegB, clock, en, clr);
	register DXIR(DX_IR, FD_IR, clock, en, clr);
	register DXimm(DX_imm_sx, imm_sx, clock, en, clr);
	register DXtarget(DX_target_sx,target_sx, clock, en, clr);
	register DXcontrol(DX_control, control, clock, en, clr);


endmodule 