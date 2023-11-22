`timescale 1ns/1ps

import ascon_pack::*;

module permutation_step2 (
	input type_state permutation_i, 
	input logic[63:0] data_i,
	input logic[127:0] key_i,
	input logic selectionp_i, clock_i, resetb_i, enable_i, bypass_i, mode_int_ext_i,
	input logic[3:0] round_i,
	output type_state permutation_o
);

type_state mux_o, p_o, xor_o;
mux m(
	.mux_perm_in(permutation_i),
	.mux_perm_out(permutation_o),
	.selection_i(selectionp_i),
	.mux_o(mux_o)
);

xor_begin XOR (
	.state_i(mux_o),
	.data_i(data_i),
	.key_i(key_i),
	.bypass_i(bypass_i),
	.mode_int_ext_i(mode_int_ext_i),
	.state_o(xor_o)
);

p perm(
	.pin_i(xor_o),
	.roundp_i(round_i),
	.pout_o(p_o)
);

dff d(
	.clock_i(clock_i),
	.resetb_i(resetb_i),
	.enable_i(enable_i),
	.d_i(p_o),
	.q_o(permutation_o)
);




endmodule
