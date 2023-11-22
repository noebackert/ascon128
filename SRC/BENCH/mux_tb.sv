`timescale 1ns/1ps
import ascon_pack::*;

module mux_tb(
);

type_state muxi_s, muxio_s, muxo_s;
logic selection_s;

mux DUT(
	.permutation_i(muxi_s),
	.permutation_o(muxio_s),
	.selection_i(selection_s),
	.mux_o(muxo_s)		
);


initial
	begin
		selection_s = 0;
	        muxi_s[0] = 64'h80400c0600000000;
                muxi_s[1] = 64'h0001020304050607;
                muxi_s[2] = 64'h08090a0b0c0d0e0f;
                muxi_s[3] = 64'h0011223344556677;
                muxi_s[4] = 64'h8899aabbccddeeff;
		muxio_s[0] = 64'he05e3fcced08e4f0;
		muxio_s[1] = 64'h0dc4f1a5aea83522;
		muxio_s[2] = 64'hfd3d3d3d3d3d3d57;
		muxio_s[3] = 64'hdcd8f4c7e363e010; 
		muxio_s[4] = 64'hdcdddddfd9dddddd;
	 	#50;
		selection_s = 1;
	end
endmodule
