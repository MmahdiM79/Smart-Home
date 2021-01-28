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
---  Module Name: Active Lights
---  Description: Module4: 
-----------------------------------------------------------*/
`timescale 1 ns/1 ns

module LampState (
	input  [ 3:0] active_lights , // number of active light
	output [15:0] lights_state    // state of lights is on
);

	 assign lights_state[ 0] = (active_lights > 4'b0000) ? 1: 0;
    assign lights_state[ 1] = (active_lights > 4'b0001) ? 1: 0;
    assign lights_state[ 2] = (active_lights > 4'b0010) ? 1: 0;
    assign lights_state[ 3] = (active_lights > 4'b0011) ? 1: 0;
    assign lights_state[ 4] = (active_lights > 4'b0100) ? 1: 0;
    assign lights_state[ 5] = (active_lights > 4'b0101) ? 1: 0;
    assign lights_state[ 6] = (active_lights > 4'b0110) ? 1: 0;
    assign lights_state[ 7] = (active_lights > 4'b0111) ? 1: 0;
    assign lights_state[ 8] = (active_lights > 4'b1000) ? 1: 0;
    assign lights_state[ 9] = (active_lights > 4'b1001) ? 1: 0;
    assign lights_state[10] = (active_lights > 4'b1010) ? 1: 0;
    assign lights_state[11] = (active_lights > 4'b1011) ? 1: 0;
    assign lights_state[12] = (active_lights > 4'b1100) ? 1: 0;
    assign lights_state[13] = (active_lights > 4'b1101) ? 1: 0;
    assign lights_state[14] = (active_lights > 4'b1110) ? 1: 0;
    assign lights_state[15] = (active_lights == 4'b1111) ? 1: 0;


    
endmodule