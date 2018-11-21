module mux_four(
	high_bit_select,
	low_bit_select,
	register0,
	register1, 
	register2,
	register3,
	register_out
);


	input low_bit_select, high_bit_select;
	input [31:0] register0, register1, register2, register3;
	output [31:0] register_out;
	
	//wire [3:0] select;
	//00, 01, 10, 11
	
	
	//3 2 bit muxes, in form of ternary operations
	//TODO: CHECK THIS LOGIC AND SYNTAX
	wire[31:0] bracket0, bracket1;
	assign bracket0 = low_bit_select ? register1 : register0;
	assign bracket1 = low_bit_select ? register3 : register2;
	
	assign register_out = high_bit_select ? bracket1 : bracket0;

endmodule 