module XM(old_pc, DX_PC, DX_IR, DX_target_sx, DX_control, X_output, DX_B, flush, clock, en, clr,
				XM_old_PC, XM_PC, XM_IR, XM_target_sx, XM_control, XM_output, XM_B_data); 



	input [31:0] DX_PC, DX_IR, DX_target_sx, DX_control, X_output, DX_B, old_pc;
	input clock, en, clr;
	output[31:0] XM_PC, XM_IR, XM_target_sx, XM_control, XM_output, XM_B_data, XM_old_PC;
	input flush;
	
	wire [31:0] new_control;
	assign new_control[30:0] = DX_control[30:0];
	assign new_control[31] = flush;
	
	

	
	register b(XM_B_data, DX_B, clock, en, clr);
	register xmoldp(XM_old_PC, old_pc, clock, en, clr);
	register XMPC(XM_PC, DX_PC, clock, en, clr);		
	register XMIR(XM_IR, DX_IR, clock, en, clr);
	register XMtarget(XM_target_sx, DX_target_sx, clock, en, clr);
	register XMcontrol(XM_control, new_control, clock, en, clr);		
	register XMoutput(XM_output, X_output, clock, en, clr);

					 
					 

endmodule 