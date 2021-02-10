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
---  Module Name: Temperature Calculator
---  Description: Module1: 
-----------------------------------------------------------*/
`timescale 1 ns/1 ns 

module TemperatureCalculator (
	input  [31:0] tc_base  , // base [environment degree ]
	input  [ 7:0] tc_ref   , // ref  [system work voltage]
	input  [15:0] adc_data , // adc  [sensor digital data]
	output [31:0] tempc      // temp [temperature celsius]
);

	
	wire [15:0] out_m8;
	Multiplier8x8 m8(tc_ref, tc_ref, out_m8);
	
	wire [31:0] out_m16;
	Multiplier16x16 m16(out_m8, {1'b1, adc_data[14:0]}, out_m16);
	
	wire [31:0] res;
	AdderSubtractor32x32 r(tc_base, out_m16, adc_data[15], res);
	
	Twos final_res(res, tempc);

endmodule




module Twos(
	input  [31:0]  in,
	output [31:0] out
);

	assign out = ~in + 1'b1;
endmodule
