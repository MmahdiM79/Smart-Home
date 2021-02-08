/*--  *******************************************************
--  Computer Architecture Course, Laboratory Sources 
--  Amirkabir University of Technology (Tehran Polytechnic)
--  Department of Computer Engineering (CE-AUT)
--  https://ce[dot]aut[dot]ac[dot]ir
--  *******************************************************
--  All Rights reserved (C) 2019-2020
--  *******************************************************
--  Student ID  : 
--  Student Name: 
--  Student Mail: 
--  *******************************************************
--  Additional Comments:
--
--*/

/*-----------------------------------------------------------
---  Module Name: 16 Bit Multiplier
---  Description: Module1: 
-----------------------------------------------------------*/
`timescale 1 ns/1 ns

module Multiplier16x16 (
	input  [15:0] A , // input  [unsigned 16 bits]
	input  [15:0] B , // input  [unsigned 16 bits]
	output [31:0] P   // output [unsigned 32 bits]
);

	wire [15:0] A_binary, B_binary;
	Binary16bit v16_1(A, A_binary);
	Binary16bit v16_2(B, B_binary);
	
	wire [15:0] A_final, B_final;
	
	wire s_a, s_b;
	assign s_a = A[15];
	assign s_b = B[15];
	
	assign A_final = s_a ? A_binary: A;
	assign B_final = s_b ? B_binary: B;

	wire [31:0] hold;
	assign hold = A_final * B_final;
	assign P = hold[31:6];

endmodule



module Binary16bit(
	input  [15:0] in,
	output [15:0] out
);

	assign out = ~(in - 1'b1);
	
endmodule