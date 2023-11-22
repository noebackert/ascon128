`timescale 1ns/1ps

import ascon_pack::*;

module permutation (
	input logic[127:0] nonce_i,
	input logic[63:0] data_i,
	input logic[127:0] key_i,
	input logic selectionp_i, clock_i, resetb_i, enable_i, bypass_begin_i, bypass_end_i, mode_int_ext_i, mode_init_data_i, en_cipher_i, en_tag_i,
	input logic[3:0] round_i,
	output logic[63:0] cipher_o,
	output logic[127:0] tag_o
);

type_state permutation_i, permutation_o, mux_o, p_o, xor_begin_o, xor_end_o;

assign permutation_i[0] = 64'h80400C0600000000; // vecteur d'initialisation
assign permutation_i[1] = key_i[127:64];
assign permutation_i[2] = key_i[63:0];
assign permutation_i[3] = nonce_i[127:64];
assign permutation_i[4] = nonce_i[63:0];

mux m(
	.mux_perm_in(permutation_i),
	.mux_perm_out(permutation_o),
	.selection_i(selectionp_i),
	.mux_o(mux_o)
);

xor_begin XORB (
	.state_i(mux_o),
	.data_i(data_i),
	.key_i(key_i),
	.bypass_i(bypass_begin_i),
	.mode_int_ext_i(mode_int_ext_i),
	.state_o(xor_begin_o)
);


p perm(
	.pin_i(xor_begin_o),
	.roundp_i(round_i),
	.pout_o(p_o)
);

xor_end XORE (
	.state_i(p_o),
	.key_i(key_i),
	.bypass_i(bypass_end_i),
	.mode_init_data_i(mode_init_data_i),
	.state_o(xor_end_o)
);

dff dff_main(
	.clock_i(clock_i),
	.resetb_i(resetb_i),
	.enable_i(enable_i),
	.d_i(xor_end_o),
	.q_o(permutation_o)
);

dffN #(.N(128)) dff_tag(
	.clock_i(clock_i),
	.resetb_i(resetb_i),
	.enable_i(en_tag_i),
	.d_i({xor_end_o[3], xor_end_o[4]}),
	.q_o(tag_o)
);

dffN #(.N(64)) dff_cypher(
	.clock_i(clock_i),
	.resetb_i(resetb_i),
	.enable_i(en_cipher_i),
	.d_i(xor_begin_o[0]),
	.q_o(cipher_o)
);


endmodule
