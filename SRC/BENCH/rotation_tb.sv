`timescale 1ns/1ps

module rotation_tb(
);

logic[63:0] roti_s, roto_s;


rotation #(.N(19)) DUT(
	.rot_i(roti_s),
	.rot_o(roto_s)
);

initial
	begin
		roti_s = 64'h80400c0600000000;
	end
endmodule
