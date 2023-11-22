`timescale 1ns/1ps
import ascon_pack::*;

module sbox_tb
(
);

logic [4:0] sbox_in;
logic [4:0] sbox_out;

sbox DUT(
	.in_i(sbox_in),
	.out_o(sbox_out)
);

initial 
	begin
		sbox_in = 5'h14;

	end
endmodule
