`timescale 1ns/1ps

import ascon_pack::*;

module xor_begin(
	input type_state state_i, 
	input logic[63:0] data_i,
	input logic[127:0] key_i,
	input logic bypass_i, mode_int_ext_i,
	//bypass_i : si == 1 => state_o = state_i, sinon state_o = state_o^data_i
	output type_state state_o
);

always @*

case({bypass_i, mode_int_ext_i})
	2'b00: 	begin 	state_o[0] = state_i[0]^data_i; 
			state_o[1] = state_i[1];
			state_o[2] = state_i[2];
			state_o[3] = state_i[3];
			state_o[4] = state_i[4];

end
	2'b01: 	begin 	
			state_o[0] = state_i[0]^data_i; ;
			state_o[1] = state_i[1]^key_i[127:64];
			state_o[2] = state_i[2]^key_i[63:0]; 
			state_o[3] = state_i[3];
			state_o[4] = state_i[4];
end
	2'b10: 	state_o = state_i;
	2'b11: 	state_o = state_i;
	default: state_o = state_i;
endcase

endmodule : xor_begin
