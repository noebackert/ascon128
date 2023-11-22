`timescale 1ns/1ps

import ascon_pack::*;

module permutation_step1(
	input type_state permutation_i, 
	input logic selectionp_i, clock_i, resetb_i, enable_i,
	input logic[3:0] round_i,
	output type_state permutation_o
);

type_state muxout, pout;
mux m(
	.mux_perm_in(permutation_i),
	.mux_perm_out(permutation_o),
	.selection_i(selectionp_i),
	.mux_o(muxout)
);

p perm(
	.pin_i(muxout),
	.roundp_i(round_i),
	.pout_o(pout)
);

dff d(
	.clock_i(clock_i),
	.resetb_i(resetb_i),
	.enable_i(enable_i),
	.d_i(pout),
	.q_o(permutation_o)
);

endmodule
