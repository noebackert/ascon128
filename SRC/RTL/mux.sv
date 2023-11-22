`timescale 1ns/1ps
import ascon_pack::*;


module mux(
	input type_state mux_perm_in, mux_perm_out,
	input logic selection_i,
	output type_state mux_o
);

assign mux_o = (selection_i) ? mux_perm_out : mux_perm_in;

endmodule
