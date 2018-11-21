module MW(XM_old_PC, XM_IR, XM_control, XM_output, q_dmem , XM_target_sx, clock, en, reset,
				 MW_old_PC, MW_IR, MW_control, MW_output, MW_dmem, MW_target_sx); 
				 
				 
	input [31:0] XM_old_PC, XM_IR, XM_control, XM_output, q_dmem , XM_target_sx;
	input clock, en, reset;
	output [31:0] MW_old_PC, MW_IR, MW_control, MW_output, MW_dmem, MW_target_sx;
	
	
	
	register MW_oldPC(MW_old_PC, XM_old_PC, clock, en, reset);
	register MWir(MW_IR, XM_IR, clock, en, reset);
	register MWctrl(MW_control, XM_control, clock, en, reset);
	
	register MWout(MW_output, XM_output, clock, en, reset);
	register MWmem(MW_dmem, q_dmem, clock, en, reset);
	register MWtarget(MW_target_sx, XM_target_sx, clock, en, reset);
				 
// MW mw1(XM_old_PC, XM_IR, XM_control, XM_output, q_dmem, XM_target_sx, clock, en, reset,
				// MW_old_PC, MW_IR, MW_control, MW_output, MW_dmem, MW_target_sx); 
				 
endmodule 