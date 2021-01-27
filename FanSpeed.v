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
---  Module Name: Fan Speed (PWM)
---  Description: Module3: 
-----------------------------------------------------------*/
`timescale 1 ns/1 ns

module FanSpeed (
	input        arst     , // reset [asynch]  
	input        clk      , // clock [posedge] 
	input  [7:0] speed    , // speed [duty-cycle]  
	output       pwm_data   // data  [output]
);

	wire cout_load, cout_init, load, init, res;
	
	wire [7:0] par_value;
	assign par_value = 9'b100000000 - speed; 
	
	Counter c_load(arst, clk, load, par_value, cout_load);
	Counter c_init(arst, clk, init, {8'b00000000}, cout_init);
	
	Controller cntrl(cout_init, cout_load, clk, arst, load, init, res);
	
	assign pwm_data = res ? 1'b0: 1'b1;

endmodule 


module Counter(
	input arst,
	input clk,
	input load,
	input [7:0] par,
	output cout
);
	
	reg [7:0] current;
	
	always @ (clk or arst)
	begin
	
		if (arst)
			current <= 8'b00000000;
			
		else
		begin
		
			if (load)
				current <= par;
			else
				current <= current + 1'b1;
		end
			
	end
	
	assign cout = &(current);
	

endmodule



module Controller(
	input cout_init,
	input cout_load,
	input clk,
	input arst,
	output load,
	output init,
	output res
);

	reg [1:0] p_s, n_s;
	
	parameter [1:0] A = 2'b00, B = 2'b01, C = 2'b10;
	
	always @ (p_s or cout_init or cout_load)
		begin
			
			n_s = B;
			case(p_s)
				A: n_s = B;
				B: n_s = cout_load ? (cout_init ? A: C): B;
				C: n_s = cout_init ? A: C;
				default: n_s = B;
			endcase
			
		end
		
		
		always @(posedge clk or  posedge arst)
		begin
			if (arst)
				p_s <= A;
			else
				p_s <= n_s;
		end 
		
		
		assign init = (p_s == A) ? 1'b1: 1'b0;
		assign load = (p_s == A) ? 1'b1: 1'b0;
		assign res = (p_s == C) ? 1'b1: 1'b0;

endmodule 