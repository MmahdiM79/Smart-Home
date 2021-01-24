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
---  Module Name: Control Unit
---  Description: Module7:
-----------------------------------------------------------*/
`timescale 1 ns/1 ns

`define A 3'b001 // IDLE
`define B 3'b010 // ACTIVE
`define C 3'b011 // REQUEST
`define D 3'b100 // STORE
`define E 3'b101 // TRAP
`define F 3'b111 // FFF

`define STATE_IDLE    3'b001
`define STATE_ACTIVE  3'b010
`define STATE_REQUEST 3'b011
`define STATE_STORE   3'b100
`define STATE_TRAP    3'b101
`define STATE_OTHERS  3'b111


module ControlUnit (
	input         arst      , // async  reset
	input         clk       , // clock  posedge
	input         request   , // request input (asynch) 
	input         confirm   , // confirm input 
	input  [ 1:0] password  , // password from user
	input  [ 1:0] syskey    , // key  from memoty unit
	input  [34:0] configin  , // conf from user
	output [34:0] configout , // conf to memory unit
	output        write_en  , // conf mem write enable
	output [ 2:0] dbg_state   // current state (debug)
	);

    wire equal;
    PassCheckUnit pcu(password, syskey, equal);


    reg [2:0] p_s, n_s;

    always @(p_s or request or confirm or equal) 
    begin
        
        case(p_s)
            `A: n_s = request ? `B: `A;
            `B: n_s = confirm ? (equal ? `C: `E): `B;
            `C: n_s = confirm ? `D: `C;
            `D: n_s = `A;
            `E: n_s = `A;
            default: n_s = `A;
        endcase

        if (~request)
            n_s = `A;

    end

    always @(posedge clk or posedge arst) 
    begin
        
        if (arst)
            p_s <= `STATE_IDLE;
        else
            p_s <= n_s;

    end


    assign write_en = (p_s == `D) ? 1'b1: 1'b0;
    assign configout = configin;
    assign dbg_state = p_s;


endmodule
