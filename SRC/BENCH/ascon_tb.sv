`timescale 1ns/1ps

import ascon_pack::*;

module ascon_tb (
);

logic data_valid_s, start_s, clock_s, resetb_s, cipher_valid_s, end_s;
logic[63:0] data_s, cipher_s, P1_s, P2_s, P3_s, P4_s;
logic[127:0] key_s, nonce_s, tag_s;
logic[3:0] round_s;
ascon DUT (
	.data_i(data_s),
	.key_i(key_s),
	.nonce_i(nonce_s),
	.start_i(start_s),
	.data_valid_i(data_valid_s),
	.clock_i(clock_s),
	.resetb_i(resetb_s),
	.end_o(end_s),
	.cipher_valid_o(cipher_valid_s),
	.cipher_o(cipher_s),
	.tag_o(tag_s)
);
initial 
	begin 
		data_s = 64'h3230323380000000;
		key_s = 128'h000102030405060708090A0B0C0D0E0F;
		nonce_s = 128'h00112233445566778899AABBCCDDEEFF;
		P1_s = 64'h436F6E636576657A;
		P2_s = 64'h204153434F4E2065;
		P3_s = 64'h6E2053797374656D;
		P4_s = 64'h566572696C6F6780;
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
		data_s = P1_s;
		data_valid_s = 1;
		#100
		data_valid_s = 0;

		#1000
		data_s = P2_s;
		data_valid_s = 1;
		#100
		data_valid_s = 0;

		#1000
		data_s = P3_s;
		data_valid_s = 1;
		#100
		data_valid_s = 0;

		#1000
		data_s = P4_s;
		data_valid_s = 1;
		#100
		data_valid_s = 0;
	end

endmodule
