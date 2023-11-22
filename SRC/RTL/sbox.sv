`timescale 1ns/1ps

import ascon_pack::*;


module sbox (
  input logic [4:0] in_i,
  output logic [4:0] out_o
);


always @(in_i)
begin : ps_behav
	case(in_i)
		5'h00: out_o = 5'h04; 
		5'h01: out_o = 5'h0B;
		5'h02: out_o = 5'h1F;
		5'h03: out_o = 5'h14;
		5'h04: out_o = 5'h1A;
		5'h05: out_o = 5'h15;
		5'h06: out_o = 5'h09;
		5'h07: out_o = 5'h02;
		5'h08: out_o = 5'h1B;
		5'h09: out_o = 5'h05;
		5'h0A: out_o = 5'h08;
		5'h0B: out_o = 5'h12;
		5'h0C: out_o = 5'h1D;
		5'h0D: out_o = 5'h03;
		5'h0E: out_o = 5'h06;
		5'h0F: out_o = 5'h1C;
		5'h10: out_o = 5'h1E;
		5'h11: out_o = 5'h13;
		5'h12: out_o = 5'h07;
		5'h13: out_o = 5'h0E;
		5'h14: out_o = 5'h00;
		5'h15: out_o = 5'h0D;
		5'h16: out_o = 5'h11;
		5'h17: out_o = 5'h18;
		5'h18: out_o = 5'h10;
		5'h19: out_o = 5'h0C;
		5'h1A: out_o = 5'h01;
		5'h1B: out_o = 5'h19;
		5'h1C: out_o = 5'h16;
		5'h1D: out_o = 5'h0A;
		5'h1E: out_o = 5'h0F;
		5'h1F: out_o = 5'h17;
		default: out_o = 5'h00;
	endcase
end : ps_behav
endmodule : sbox

