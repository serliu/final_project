module counter(clock, reset, count);

	input clock;
	input reset;
	output[31:0] count;
	
	wire en, pr;
	assign en = 1'b1;
	assign pr = 1'b1;
	wire in0;
	assign in0 = 1'b1;
	
	wire reset_out;
	assign reset_out = reset;

	
//	 wire q_out;
//	 dflipflop dff10(reset, clock, 1'b0, 1'b0, 1'b1, q_out);
//	 wire or_out, not_out;
//	 or or1(or_out, clock, q_out);
//	 not not1(not_out, or_out);
//	 dflipflop dff11(not_out, clock, 1'b0, 1'b0, reset, reset_out);
	
	 dflipflop dff0(in0, clock, reset_out, pr, en, count[0]);
	
	generate
	  genvar i;
	  for (i = 1; i < 32; i = i + 1)
	  begin : gen1
		dflipflop dff1(count[i-1], clock, reset_out, pr, en, count[i]);
	  end
	endgenerate 





endmodule 