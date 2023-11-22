`timescale 1ns/1ps

import ascon_pack::*;

module permutation_tb(
);

logic selectionp_s, clock_s, resetb_s, enable_s, bypass_begin_s, bypass_end_s, mode_int_ext_s, mode_init_data_s, en_cipher_s, en_tag_s;
logic[3:0] round_s;
logic[63:0] data_s, cipher_s;
logic[127:0] key_s, tag_s, nonce_s;


permutation DUT(
	.nonce_i(nonce_s),
	.data_i(data_s),
	.key_i(key_s),
	.selectionp_i(selectionp_s),
	.clock_i(clock_s),
	.resetb_i(resetb_s),
	.enable_i(enable_s),
	.bypass_begin_i(bypass_begin_s),
	.bypass_end_i(bypass_end_s),
	.mode_int_ext_i(mode_int_ext_s),
	.mode_init_data_i(mode_init_data_s),
	.en_cipher_i(en_cipher_s),
	.en_tag_i(en_tag_s),
	.round_i(round_s),
	.cipher_o(cipher_s),
	.tag_o(tag_s)
);

//declaration var
initial 
	begin 
		integer i;
		//data_s = 64'h436F6E636576657A;
		key_s = 128'h000102030405060708090A0B0C0D0E0F;
		nonce_s = 128'h00112233445566778899AABBCCDDEEFF;
		mode_int_ext_s = 0; //mode xor data
		mode_init_data_s = 0;
		bypass_begin_s = 1;
		bypass_end_s = 1;
	end


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


// gestion de selectionp_s
initial
begin 
	integer i;
	selectionp_s = 0;
	#60;
	selectionp_s = 1;
	for (i=0; i < 11; i ++) begin
		#100;
		end
	#100;
	
end

//gestion de round_s
initial 
begin
	integer i;
	enable_s = 1;
	for (i=0; i < 12; i ++) begin
		round_s = i;
		#100;
		end
	enable_s = 0;
end


endmodule
