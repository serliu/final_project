module sixty_four_register(register_out_sf, register_in_sf, clk, en, clr  ); 

	output[64:0] register_out_sf;
	input[64:0] register_in_sf;
	input clk, en, clr;
	
	
	
	register r0(register_out_sf[64:33], register_in_sf[64:33], clk, en, clr ); 
	register r1(register_out_sf[32:1], register_in_sf[32:1], clk, en, clr ); 
	dffe_ref r2(register_out_sf[0], register_in_sf[0], clk, en, clr);


endmodule 