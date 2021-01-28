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
---  Module Name: Light Dance
---  Description: Module5
-----------------------------------------------------------*/
`timescale 1 ns/1 ns

module LightDance (
	input        arst  , // async  reset
	input        clk   , // clock  posedge
	input        din   , // input  data
	input        load  , // load   enable 
	input  [7:0] pdata , // load   data
	output [7:0] qdata   // output data
);

    wire [7:0] din_df, dout_df;

    assign din_df[0] = (load == 1'b1) ?  pdata[0]: (dout_df[0]^dout_df[1]);
    assign din_df[1] = (load == 1'b1) ?  pdata[1]: (dout_df[0]^dout_df[2]);
    assign din_df[2] = (load == 1'b1) ?  pdata[2]: (dout_df[3]);
    assign din_df[3] = (load == 1'b1) ?  pdata[3]: (dout_df[4]);
    assign din_df[4] = (load == 1'b1) ?  pdata[4]: (dout_df[0]^dout_df[5]);
    assign din_df[5] = (load == 1'b1) ?  pdata[5]: (dout_df[0]^dout_df[6]);
    assign din_df[6] = (load == 1'b1) ?  pdata[6]: (dout_df[7]);
    assign din_df[7] = (load == 1'b1) ?  pdata[7]: (din^dout_df[0]);


    DFlop d0(arst, clk, din_df[0], 1'b1, dout_df[0]);
    DFlop d1(arst, clk, din_df[1], 1'b1, dout_df[1]);
    DFlop d2(arst, clk, din_df[2], 1'b1, dout_df[2]);
    DFlop d3(arst, clk, din_df[3], 1'b1, dout_df[3]);
    DFlop d4(arst, clk, din_df[4], 1'b1, dout_df[4]);
    DFlop d5(arst, clk, din_df[5], 1'b1, dout_df[5]);
    DFlop d6(arst, clk, din_df[6], 1'b1, dout_df[6]);
    DFlop d7(arst, clk, din_df[7], 1'b1, dout_df[7]);


    assign qdata = dout_df;

endmodule
