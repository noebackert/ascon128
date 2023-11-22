`timescale 1ns/1ps

import ascon_pack::*;

module permutation_step3bis_tb(
);

type_state permutationi_s, permutationo_s;
logic selectionp_s, clock_s, resetb_s, enable_s, bypass_s, mode_int_ext_s;
logic[3:0] round_s;
logic[63:0] data_s, C_s;
logic[127:0] key_s;


permutation_step3 DUT(
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
	.permutation_o(permutationo_s),
	.C_o(C_s)
);

//declaration var
initial 
	begin 
		integer i;
		data_s = 64'h436F6E636576657A;
		key_s = 128'h000102030405060708090A0B0C0D0E0F;
		mode_int_ext_s = 0; //mode xor data

		for (i=6; i < 12; i ++) begin
			#100;
			end
		data_s = 64'h204153434F4E2065;
		for (i=6; i < 12; i ++) begin
			#100;
			end
		data_s = 64'h6E2053797374656D;
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
	integer i;
	bypass_s = 0;
	selectionp_s = 0;
	#50
	bypass_s = 1;
	selectionp_s = 1;
	for (i=6; i < 11; i ++) begin
		#100;
		end
	bypass_s = 0;
	#100
	bypass_s = 1;
	for (i=6; i < 11; i ++) begin
		#100;
		end
	bypass_s = 0;
	#100
	bypass_s = 1;
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
	for (i=6; i < 12; i ++) begin
		round_s = i;
		#100;
		end
	for (i=6; i < 12; i ++) begin
		round_s = i;
		#100;
		end
	enable_s = 0;
end

//gestion de permutation_in_s
initial
begin

	permutationi_s[0] = 64'h4608da0e76fcee25;
	permutationi_s[1] = 64'h876f2d998dd3ed21;
	permutationi_s[2] = 64'h5d5b8b59b7ac16ee;
	permutationi_s[3] = 64'he23c656f97f63dc8;
	permutationi_s[4] = 64'h3e09499302483746;
end

endmodule
