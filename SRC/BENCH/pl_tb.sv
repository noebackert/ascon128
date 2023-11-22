`timescale 1ns/1ps

import ascon_pack::*;

module pl_tb(
    
);

type_state plin_s, plout_s;


pl DUT(
	.plin_i(plin_s),
	.plout_o(plout_s)
);

initial 
	begin
		/*plin_s[0] = 64'h8859263f4c5d6e8f;
		plin_s[1] = 64'h00c18e8584858607;
		plin_s[2] = 64'h7f7f7f7f7f7f7f8f;
		plin_s[3] = 64'h80c0848680808070;
		plin_s[4] = 64'h8888888a88888888;*/
		plin_s[0] = 64'h3404dc14c532069b;
		plin_s[1] = 64'h6569aa62e997dbbb;
		plin_s[2] = 64'h5f013068e003b533;
		plin_s[3] = 64'hb81a49b9cf6483a8;
		plin_s[4] = 64'h2c342330ea6066d3;
		#10;
	end
endmodule
