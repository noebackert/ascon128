`timescale 1ns/1ps

import ascon_pack::*;

module permutation_step1_tb(
);

type_state permutationi_s, permutationo_s;
logic selectionp_s, clock_s, resetb_s, enable_s;
logic[3:0] round_s;

permutation_step1 DUT(
	.permutation_i(permutationi_s),
	.selectionp_i(selectionp_s),
	.clock_i(clock_s),
	.resetb_i(resetb_s),
	.enable_i(enable_s),
	.round_i(round_s),
	.permutation_o(permutationo_s)
);

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
	selectionp_s = 0;
	#60
	selectionp_s = 1;
end

//gestion de round_s
initial 
begin
	integer i;
	enable_s = 1;
	for (i=0; i < 12; i ++) begin
		round_s = i;
		#100;
		end
	enable_s = 0;
end


//gestion de permutation_in_s
initial
begin
	permutationi_s[0] = 64'h80400c0600000000;
	permutationi_s[1] = 64'h0001020304050607;
	permutationi_s[2] = 64'h08090a0b0c0d0e0f;
	permutationi_s[3] = 64'h0011223344556677;
	permutationi_s[4] = 64'h8899aabbccddeeff;
end

endmodule
