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
---  Module Name: 8 Bit Multiplier
---  Description: Module1: 
-----------------------------------------------------------*/
`timescale 1 ns/1 ns

module Multiplier8x8 (
	input  [ 7:0] A ,  // input  [unsigned 08 bits]
	input  [ 7:0] B ,  // input  [unsigned 08 bits]
	output [15:0] P    // output [unsigned 16 bits]
	);
	
	wire [7:0] A_binary, B_binary;
	Binary8bit v8_1(A, A_binary);
	Binary8bit v8_2(B, B_binary);
	
	wire [7:0] A_final, B_final;
	
	wire s_a, s_b;
	assign s_a = A[7];
	assign s_b = B[7];
	
	assign A_final = s_a ? A_binary: A;
	assign B_final = s_b ? B_binary: B;

	assign P = A_final * B_final;

endmodule



module Binary8bit(
	input  [7:0] in,
	output [7:0] out
);

	assign out = ~(in - 1'b1);
	
endmodule
