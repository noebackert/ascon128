`timescale 1ns/1ps

import ascon_pack::*;

module p(
    	input type_state pin_i, 
		input logic[3:0] roundp_i,
    	output type_state pout_o
);

type_state pcout, psout;

pc pc1(
	.pcin_i(pin_i),
	.round_i(roundp_i),
	.pcout_o(pcout)
);

ps ps1(
	.psin_i(pcout),
	.psout_o(psout)
);

pl pl1(
	.plin_i(psout),
	.plout_o(pout_o)
);


endmodule : p
