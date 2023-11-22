`timescale 1ns/1ps
import ascon_pack::*;


module ascon(
	input logic[63:0] data_i,
	input logic[127:0] key_i, nonce_i,
	input logic start_i, data_valid_i, clock_i, resetb_i,
	output logic end_o, cipher_valid_o,
	output logic[63:0] cipher_o,
	output logic[127:0] tag_o
);

logic data_sel_s, bypass_begin_s, bypass_end_s, mode_int_ext_s, mode_init_data_s, en_cipher_s, en_tag_s;
logic init_cpt_2_s, en_cpt_2_s, en_p_s;
logic[1:0] block_s;
logic[3:0] round_s;
logic init_a_s, init_b_s, en_cpt_s;

permutation p(
	.data_i(data_i),
	.key_i(key_i),
	.nonce_i(nonce_i),
	.selectionp_i(data_sel_s), 
	.clock_i(clock_i), 
	.resetb_i(resetb_i), 
	.enable_i(en_p_s), 
	.bypass_begin_i(bypass_begin_s), 
	.bypass_end_i(bypass_end_s), 
	.mode_int_ext_i(mode_int_ext_s), 
	.mode_init_data_i(mode_init_data_s), 
	.en_cipher_i(en_cipher_s), 
	.en_tag_i(en_tag_s),
	.round_i(round_s),
	.cipher_o(cipher_o),
	.tag_o(tag_o)
);

fsm_moore f(
	.round_i(round_s),
	.resetb_i(resetb_i),
	.clock_i(clock_i),
	.start_i(start_i),
	.data_valid_i(data_valid_i),
	.block_s(block_s),
	.cipher_valid_o(cipher_valid_o),
	.end_o(end_o),
	.en_cpt_o(en_cpt_s),
	.init_a_o(init_a_s),
	.init_b_o(init_b_s),
	.data_sel_o(data_sel_s),
	.bypass_begin_o(bypass_begin_s),
	.bypass_end_o(bypass_end_s),
	.mode_int_ext_o(mode_int_ext_s),
	.mode_init_data_o(mode_init_data_s),
	.en_cipher_o(en_cipher_s),
	.en_tag_o(en_tag_s),
	.en_p_o(en_p_s),
	.init_cpt_2_o(init_cpt_2_s),
	.en_cpt_2_o(en_cpt_2_s)
);

compteur_blocs cpt_b(
	.clock_i(clock_i),
	.resetb_i(resetb_i),
	.en_blocs_i(en_cpt_2_s),
	.init_i(init_cpt_2_s),
	.cpt_blocs_o(block_s)
);

compteur_double_init cpt_di(
	.clock_i(clock_i),
	.resetb_i(resetb_i),
	.en_cpt_i(en_cpt_s),
	.init_a_i(init_a_s),
	.init_b_i(init_b_s),
	.cpt_o(round_s)
);

endmodule