`timescale 1ns/1ps
import ascon_pack::*;

module ps_tb
(
);

type_state psout_s, psin_s;

ps DUT(
	.psout_o(psout_s),
	.psin_i(psin_s)
);

initial 
	begin
		/*psin_s[0] = 64'h80400c0600000000;
		psin_s[1] = 64'h0001020304050607;
		psin_s[2] = 64'h08090a0b0c0d0eff;
		psin_s[3] = 64'h0011223344556677;
		psin_s[4] = 64'h8899aabbccddeeff;*/

		psin_s[0] = 64'h598da474303d9164;
		psin_s[1] = 64'h7559456e06c73ad3;
		psin_s[2] = 64'h94beaba9335e441f;
		psin_s[3] = 64'h8866d2abc492c960;
		psin_s[4] = 64'hc11bf1d12e77b520;
		#10;
	end
endmodule
