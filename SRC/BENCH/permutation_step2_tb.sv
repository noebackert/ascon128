`timescale 1ns/1ps

import ascon_pack::*;

module permutation_step2_tb(
);

type_state permutationi_s, permutationo_s;
logic selectionp_s, clock_s, resetb_s, enable_s, bypass_s, mode_int_ext_s;
logic[3:0] round_s;
logic[63:0] data_s;
logic[127:0] key_s;

/*
input type_state permutation_i, 
	input logic[63:0] data_i,
	input logic[127:0] key_i,
	input logic selectionp_i, clock_i, resetb_i, enable_i, bypass_i, mode_int_ext_i,
	input logic[3:0] round_i,
	output type_state permutation_o
*/
permutation_step2 DUT(
	.permutation_i(permutationi_s),
	.data_i(data_s),
	.key_i(key_s),
	.selectionp_i(selectionp_s),
	.clock_i(clock_s),
	.resetb_i(resetb_s),
	.enable_i(enable_s),
	.bypass_i(bypass_s),
	.mode_int_ext_i(mode_int_ext_s),
	.round_i(round_s),
	.permutation_o(permutationo_s)
);

//declaration var
initial 
	begin 
		data_s = 64'h3230323380000000;
		//key_s inutile
		key_s = 128'h000102030405060708090A0B0C0D0E0F;
		mode_int_ext_s = 0; //mode xor data
		
	end


// generation clock
initial 
	begin 
		clock_s = 0;
		forever #50 clock_s = ~clock_s;
	end

// gestion du resetb_i
initial
begin
	resetb_s = 0;
	#25
	resetb_s = 1;
end


// gestion de selectionp_s
initial
begin 
	bypass_s = 0;
	selectionp_s = 0;
	#60
	bypass_s = 1;
	selectionp_s = 1;
end

//gestion de round_s
initial 
begin
	integer i;
	enable_s = 1;
	for (i=6; i < 12; i ++) begin
		round_s = i;
		#100;
		end
	enable_s = 0;
end


//gestion de permutation_in_s
initial
begin

	permutationi_s[0] = 64'h1b1354db77e0dbb4;
	permutationi_s[1] = 64'h6f140401cfa0873c;
	permutationi_s[2] = 64'hd7e8abaf45f2885a;
	permutationi_s[3] = 64'hc0c5777fa661625e;
	permutationi_s[4] = 64'hfc4374d28210928c;
end

endmodule
