`timescale 1ns/1ps

import ascon_pack::*;

module ps(
	input type_state psin_i, 
	output type_state psout_o
);


genvar i;
generate
	for (i=0 ; i < 64 ; i++)
		begin: label1
			sbox s(
			.in_i({psin_i[0][i],psin_i[1][i],psin_i[2][i],psin_i[3][i],psin_i[4][i]}),
			.out_o({psout_o[0][i],psout_o[1][i],psout_o[2][i],psout_o[3][i],psout_o[4][i]})
			);
		end
endgenerate

endmodule : ps
