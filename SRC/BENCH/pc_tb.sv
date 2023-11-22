`timescale 1ns/1ps
import ascon_pack::*;

module pc_tb
(
);

logic [3:0] round_s;
type_state pcout_s, pcin_s;

pc DUT(
	.pcout_o(pcout_s),
	.pcin_i(pcin_s),
	.round_i(round_s)	
);

initial 
	begin
		round_s = 2;
		/*pcin_s[0] = 64'h80400c0600000000;
		pcin_s[1] = 64'h0001020304050607;
		pcin_s[2] = 64'h08090a0b0c0d0e0f;
		pcin_s[3] = 64'h0011223344556677;
		pcin_s[4] = 64'h8899aabbccddeeff;*/

		pcin_s[0] = 64'h598da474303d9164;
		pcin_s[1] = 64'h7559456e06c73ad3;
		pcin_s[2] = 64'h94beaba9335e44cd;
		pcin_s[3] = 64'h8866d2abc492c960;
		pcin_s[4] = 64'hc11bf1d12e77b520;
		#10;
	end
endmodule
