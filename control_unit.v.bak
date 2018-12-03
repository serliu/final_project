module control_unit(FD_IR, control);


	input [31:0] FD_IR;
	output [31:0] control;



	assign control[0] = ~|FD_IR[31:27]; //r type = 00000
	assign control[1] = control[0] || control[2]; // has rs--> don't think this is important 
	assign control[2] = control[5] || control [16] || control[17] || (~|FD_IR[31:30] && FD_IR[29] && ~FD_IR[28] && FD_IR[27]);  //sw, lw, bne, blt, addi for immediates
	assign control[3] = control[8] || control[17] || control[19] || control[18] || control [21];  //writes to pc - blt,bne, jr, bex, jal, j
	assign control[4] = control[0] || control[16] || control[18] || control[13] || control[22]; // writes to a reg -- has rd to write, r-type, lw, addi, jal, setx
	assign control[5] = ~|FD_IR[31:30] && &FD_IR[29:27];  //sw = 00111
	
	assign control[7] = control[0] && control[22]; //rstatus = rtype & setx
	assign control[8] = FD_IR[31] && ~FD_IR[30] && &FD_IR[29:28] && ~FD_IR[27]; //bex = 10110
	assign control[9] = control[19] || control[17] || control[5]; 
	assign control[10] = control[19] || control[5];
	assign control[11] = control[15] || control[23];
	
	assign control[12] = control[0] && ~|FD_IR[6:2];
	assign control[14] = control[0] && (~|FD_IR[6:3] && FD_IR[2]);
	assign control[13] = ~|FD_IR[31:30] && FD_IR[29] && ~FD_IR[28] && FD_IR[27]; //is addi
	assign control[15] = control[0] && (~|FD_IR[6:5] &&  &FD_IR[4:3] && ~FD_IR[2]); //is r type and the alu op code is MULT 00110
	assign control[16] = ~FD_IR[31] && FD_IR[30] && ~|FD_IR[29:27]; //lw= 01000
	assign control[17] = control[24] || control[25]; //is bne or blt
	assign control[18] = ~|FD_IR[31:29] && &FD_IR[28:27]; //jal = 00011
	assign control[19] =  ~|FD_IR[31:30] && FD_IR[29] && ~|FD_IR[28:27]; // jr (00100)
	assign control[20] = control[21] ||  control[22] || control[8] ||  control[18];
	assign control[21] =  ~|FD_IR[31:28] && FD_IR[27]; //j (00001)
	assign control[22] = FD_IR[31] && ~FD_IR[30] && FD_IR[29] && ~FD_IR[28] && FD_IR[27]; //setx (10101)
	assign control[23] = control[0] && (~|FD_IR[6:5] &&  &FD_IR[4:2]); // is r type and div
	assign control[24] = (~|FD_IR[31:29] && FD_IR[28] && ~FD_IR[27]);
	assign control[25] = (~|FD_IR[31:30] && &FD_IR[29:28] && ~FD_IR[27]);
	
	
endmodule 