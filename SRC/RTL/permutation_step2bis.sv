`timescale 1ns/1ps

import ascon_pack::*;

module permutation_step2bis (
	input type_state permutation_i, 
	input logic[63:0] data_i,
	input logic[127:0] key_i,
	input logic selectionp_i, clock_i, resetb_i, enable_i, bypass_begin_i, bypass_end_i, mode_int_ext_i, mode_init_data_i,
	input logic[3:0] round_i,
	output type_state permutation_o
);

type_state mux_o, p_o, xorb_o, xore_o;
mux m(
	.mux_perm_in(permutation_i),
	.mux_perm_out(permutation_o),
	.selection_i(selectionp_i),
	.mux_o(mux_o)
);

xor_begin XOR_B (
	.state_i(mux_o),
	.data_i(data_i),
	.key_i(key_i),
	.bypass_i(bypass_begin_i),
	.mode_int_ext_i(mode_int_ext_i),
	.state_o(xorb_o)
);

p perm(
	.pin_i(xorb_o),
	.roundp_i(round_i),
	.pout_o(p_o)
);

xor_end XOR_E (
	.state_i(p_o),
	.key_i(key_i),
	.bypass_i(bypass_end_i),
	.mode_init_data_i(mode_init_data_i),
	.state_o(xore_o)

);


dff d(
	.clock_i(clock_i),
	.resetb_i(resetb_i),
	.enable_i(enable_i),
	.d_i(xore_o),
	.q_o(permutation_o)
);





endmodule
