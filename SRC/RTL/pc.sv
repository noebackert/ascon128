`timescale 1ns/1ps

import ascon_pack::*;

module pc(
	input type_state pcin_i, 
	input logic[3:0] round_i,
	output type_state pcout_o
);


assign pcout_o[0] = pcin_i[0];
assign pcout_o[1] = pcin_i[1];
assign pcout_o[3] = pcin_i[3];
assign pcout_o[4] = pcin_i[4];


assign pcout_o[2][63:0] = pcin_i[2]^{56'b0,round_constant[round_i]};
endmodule : pc
