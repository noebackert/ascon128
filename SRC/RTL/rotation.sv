`timescale 1ns/1ps

//import ascon_pack::*;

module rotation #(parameter N = 1) (
	input logic[63:0] rot_i, 
	output logic[63:0] rot_o
);


always @(rot_i)
	begin
		rot_o = {rot_i[N-1:0], rot_i[63:N]};
	end
endmodule : rotation



