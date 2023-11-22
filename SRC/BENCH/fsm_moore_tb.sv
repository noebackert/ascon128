`timescale 1ns/1ps

import ascon_pack::*;

module fsm_moore_tb (
);

logic data_valid_s, start_s, clock_s, resetb_s, cipher_valid_s, end_s, enable_round_s, initA_s, initB_s, data_sel_s, bypass_begin_s, bypass_end_s, mode_int_ext_s, mode_init_data_s, en_cipher_s, en_tag_s, en_p_s;
logic[3:0] round_s;
logic[1:0] block_s;
fsm_moore DUT (
	.data_valid_i(data_valid_s),
	.start_i(start_s),
	.clock_i(clock_s),
	.resetb_i(resetb_s),
	.round_i(round_s),
	.cipher_valid_o(cipher_valid_s),
	.end_o(end_s),
	.en_cpt_o(enable_round_s),
	.init_a_o(initA_s),
	.init_b_o(initB_s),
	.data_sel_o(data_sel_s),
	.bypass_begin_o(bypass_begin_s),
	.bypass_end_o(bypass_end_s),
	.mode_int_ext_o(mode_int_end_s),
	.mode_init_data_o(mode_init_data_s),
	.en_cipher_o(en_cipher_s),
	.en_tag_o(en_tag_s),
	.en_p_o(en_p_s),
	.block_s(block_s)
);

compteur_double_init CDI(
	.clock_i(clock_s),
    	.resetb_i(resetb_s),
    	.en_cpt_i(enable_round_s),
    	.init_a_i(initA_s),
    	.init_b_i(initB_s),
    	.cpt_o(round_s)  
);

compteur_blocs CB (
    .clock_i(clock_s),
    .resetb_i(resetb_s),
    .en_blocs_i(en_cipher_s),
    .init_i(en_p_s),
    .cpt_blocs_o(block_s)   
);

// generation clock
initial 
	begin 
		clock_s = 0;
		forever #50 clock_s = ~clock_s;
	end

// gestion du resetb_i
initial
begin
	resetb_s = 0;
	#25
	resetb_s = 1;
end

initial 
	begin 
		data_valid_s = 0;
		start_s = 0;
		#100
		start_s = 1;
		#1800
		data_valid_s = 1;
		start_s = 0;
		#100
		data_valid_s = 0;
		#1000
		data_valid_s = 1;
		#100
		data_valid_s = 0;
		#1000
		data_valid_s = 1;
		#100
		data_valid_s = 0;
		#1000
		data_valid_s = 1;
		#100
		data_valid_s = 0;
		#1000
		data_valid_s = 1;
		#100
		data_valid_s = 0;
	end

endmodule
