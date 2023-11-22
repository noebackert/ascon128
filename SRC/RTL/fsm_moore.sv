`timescale 1ns/1ps

import ascon_pack::*;

module fsm_moore (
	input logic data_valid_i, start_i, clock_i, resetb_i,
	input logic[3:0] round_i,
	input logic[1:0] block_s,
	output logic cipher_valid_o, end_o, en_cpt_o, init_a_o, init_b_o, data_sel_o, bypass_begin_o, bypass_end_o, mode_int_ext_o, mode_init_data_o, en_cipher_o, en_tag_o, en_p_o, init_cpt_2_o, en_cpt_2_o
);

// enumeration of states
typedef enum {idle, set_cpt, conf_init, init, end_init, wait_datavalid, conf_data_associe, data_associe, end_data_associe, conf_cipher, cipher, end_cipher, wait_last_cipher, last_cipher, conf_finalisation, finalisation, tag_finalisation, end_finalisation} state_t;

state_t current_state, next_state, jump_state;



always_ff @ ( posedge clock_i or negedge resetb_i )
begin : seq_0
	if (resetb_i == 0)
		current_state <= idle;
	else
		current_state <= next_state;
		
end : seq_0


// inputs
always_comb
begin : comb_0
	case ( current_state )
	idle : begin
		jump_state = idle;
		if (start_i == 0)
			next_state = idle ;
		else
			next_state = set_cpt;
	end
	set_cpt: next_state = conf_init;
	conf_init: next_state = init;
	init: if (round_i == 10)
			next_state = end_init;
		else
			next_state = init;
	
	end_init: begin
		next_state = wait_datavalid;
		jump_state = conf_data_associe;
	end
	conf_data_associe: next_state = data_associe;
	data_associe: 
		if (round_i == 10)
			next_state = end_data_associe;  
		else
			next_state = data_associe;
	end_data_associe: begin
		next_state = wait_datavalid;
		jump_state = conf_cipher;
	end

	conf_cipher: next_state = cipher;
	cipher:	begin
		if (round_i == 10)	
			next_state = end_cipher;
		else
			next_state = cipher;
	end

	end_cipher: begin	
		if (block_s == 3)
			next_state = wait_last_cipher;
		else
			next_state = wait_datavalid;
			jump_state = conf_cipher;

	end
	wait_last_cipher: begin 
		if (data_valid_i == 1)
			next_state = conf_finalisation;
		else
			next_state = wait_last_cipher;
	end
		
	last_cipher: next_state = conf_finalisation;			
	conf_finalisation: next_state = finalisation;
	finalisation: if (round_i == 10)
			next_state = tag_finalisation;
		else
			next_state = finalisation;
	tag_finalisation: next_state = end_finalisation;
	end_finalisation: next_state = idle;

	wait_datavalid: if (data_valid_i == 1)
			next_state = jump_state;
		else
			next_state = wait_datavalid;
	
	
	default : next_state = idle;
	endcase ; // case (current_state)
end : comb_0

//outputs
always_comb
begin : comb_1
	case (current_state)
	idle: begin 
		cipher_valid_o = 1'b0;
		end_o =  1'b0;
		en_cpt_o = 1'b0;
		init_a_o = 1'b0;
		init_b_o = 1'b0;
		data_sel_o = 1'b0;
		bypass_begin_o = 1'b1;
		bypass_end_o = 1'b1;
		mode_int_ext_o = 1'b0;
		mode_init_data_o = 1'b0;
		en_cipher_o = 1'b0;
		en_tag_o = 1'b0;
		en_p_o = 1'b0;
		init_cpt_2_o = 1'b0; 
		en_cpt_2_o = 1'b0;
	end 
	set_cpt: begin 
		cipher_valid_o = 1'b0;
		end_o =  1'b0;
		en_cpt_o = 1'b1;
		init_a_o = 1'b1;
		init_b_o = 1'b0;
		data_sel_o = 1'b0;
		bypass_begin_o = 1'b1;
		bypass_end_o = 1'b1;
		mode_int_ext_o = 1'b0;
		mode_init_data_o = 1'b0;
		en_cipher_o = 1'b0;
		en_tag_o = 1'b0;
		en_p_o = 1'b0;
		init_cpt_2_o = 1'b0; 
		en_cpt_2_o = 1'b0;
	end
	conf_init: begin 
		cipher_valid_o = 1'b0;
		end_o =  1'b0;
		en_cpt_o = 1'b1;
		init_a_o = 1'b0;
		init_b_o = 1'b0;
		data_sel_o = 1'b0;
		bypass_begin_o = 1'b1;
		bypass_end_o = 1'b1;
		mode_int_ext_o = 1'b0;
		mode_init_data_o = 1'b0;
		en_cipher_o = 1'b0;
		en_tag_o = 1'b0;
		en_p_o = 1'b1;
		init_cpt_2_o = 1'b0; 
		en_cpt_2_o = 1'b0;
		end 
	init: begin 
		cipher_valid_o = 1'b0;
		end_o =  1'b0;
		en_cpt_o = 1'b1;
		init_a_o = 1'b0;
		init_b_o = 1'b0;
		data_sel_o = 1'b1;
		bypass_begin_o = 1'b1;
		bypass_end_o = 1'b1;
		mode_int_ext_o = 1'b0;
		mode_init_data_o = 1'b0;
		en_cipher_o = 1'b0;
		en_tag_o = 1'b0;
		en_p_o = 1'b1;
		init_cpt_2_o = 1'b0; 
		en_cpt_2_o = 1'b0;
		end 
	end_init: begin 
		cipher_valid_o = 1'b0;
		end_o =  1'b0;
		en_cpt_o = 1'b0;
		init_a_o = 1'b0;
		init_b_o = 1'b0;
		data_sel_o = 1'b1;
		bypass_begin_o = 1'b1;
		bypass_end_o = 1'b0;
		mode_int_ext_o = 1'b0;
		mode_init_data_o = 1'b0;
		en_cipher_o = 1'b0;
		en_tag_o = 1'b0;
		en_p_o = 1'b1;
		init_cpt_2_o = 1'b0; 
		en_cpt_2_o = 1'b0;
		end 
	wait_datavalid: begin 
		cipher_valid_o = 1'b0;
		end_o =  1'b0;
		en_cpt_o = 1'b1;
		init_a_o = 1'b0;
		init_b_o = 1'b1;
		data_sel_o = 1'b1;
		bypass_begin_o = 1'b1;
		bypass_end_o = 1'b1;
		mode_int_ext_o = 1'b0;
		mode_init_data_o = 1'b0;
		en_cipher_o = 1'b0;
		en_tag_o = 1'b0;
		en_p_o = 1'b0;
		init_cpt_2_o = 1'b0; 
		en_cpt_2_o = 1'b0;
		end
	conf_data_associe: begin 
		cipher_valid_o = 1'b0;
		end_o =  1'b0;
		en_cpt_o = 1'b1;
		init_a_o = 1'b0;
		init_b_o = 1'b0;
		data_sel_o = 1'b1;
		bypass_begin_o = 1'b0;
		bypass_end_o = 1'b1;
		mode_int_ext_o = 1'b0;
		mode_init_data_o = 1'b0;
		en_cipher_o = 1'b0;
		en_tag_o = 1'b0;
		en_p_o = 1'b1;
		init_cpt_2_o = 1'b0; 
		en_cpt_2_o = 1'b0;
		end 
	data_associe: begin 
		cipher_valid_o = 1'b0;
		end_o =  1'b0;
		en_cpt_o = 1'b1;
		init_a_o = 1'b0;
		init_b_o = 1'b0;
		data_sel_o = 1'b1;
		bypass_begin_o = 1'b1;
		bypass_end_o = 1'b1;
		mode_int_ext_o = 1'b0;
		mode_init_data_o = 1'b0;
		en_cipher_o = 1'b0;
		en_tag_o = 1'b0;
		en_p_o = 1'b1;
		init_cpt_2_o = 1'b0; 
		en_cpt_2_o = 1'b0;
		end 
	end_data_associe: begin 
		cipher_valid_o = 1'b0;
		end_o =  1'b0;
		en_cpt_o = 1'b0;
		init_a_o = 1'b0;
		init_b_o = 1'b0;
		data_sel_o = 1'b1;
		bypass_begin_o = 1'b1;
		bypass_end_o = 1'b0;
		mode_int_ext_o = 1'b0;
		mode_init_data_o = 1'b1;
		en_cipher_o = 1'b0;
		en_tag_o = 1'b0;
		en_p_o = 1'b1;
		init_cpt_2_o = 1'b0; 
		en_cpt_2_o = 1'b0;
		end 
	conf_cipher:  begin 
		cipher_valid_o = 1'b0;
		end_o =  1'b0;
		en_cpt_o = 1'b1;
		init_a_o = 1'b0;
		init_b_o = 1'b0;
		data_sel_o = 1'b1;
		bypass_begin_o = 1'b0;
		bypass_end_o = 1'b1;
		mode_int_ext_o = 1'b0;
		mode_init_data_o = 1'b0;
		en_cipher_o = 1'b1;
		en_tag_o = 1'b0;
		en_p_o = 1'b1;
		init_cpt_2_o = 1'b1; 
		en_cpt_2_o = 1'b1;
		end 
	cipher: begin 
		cipher_valid_o = 1'b0;
		end_o =  1'b0;
		en_cpt_o = 1'b1;
		init_a_o = 1'b0;
		init_b_o = 1'b0;
		data_sel_o = 1'b1;
		bypass_begin_o = 1'b1;
		bypass_end_o = 1'b1;
		mode_int_ext_o = 1'b0;
		mode_init_data_o = 1'b0;
		en_cipher_o = 1'b0;
		en_tag_o = 1'b0;
		en_p_o = 1'b1;
		init_cpt_2_o = 1'b0; 
		en_cpt_2_o = 1'b1;
		end 
	end_cipher: begin 
		cipher_valid_o = 1'b0;
		end_o =  1'b0;
		en_cpt_o = 1'b1;
		init_a_o = 1'b0;
		init_b_o = 1'b0;
		data_sel_o = 1'b1;
		bypass_begin_o = 1'b1;
		bypass_end_o = 1'b1;
		mode_int_ext_o = 1'b0;
		mode_init_data_o = 1'b0;
		en_cipher_o = 1'b0;
		en_tag_o = 1'b0;
		en_p_o = 1'b1;
		init_cpt_2_o = 1'b0; 
		en_cpt_2_o = 1'b0;
		end 
	wait_last_cipher: begin 
		cipher_valid_o = 1'b0;
		end_o =  1'b0;
		en_cpt_o = 1'b1;
		init_a_o = 1'b1;
		init_b_o = 1'b0;
		data_sel_o = 1'b1;
		bypass_begin_o = 1'b1;
		bypass_end_o = 1'b1;
		mode_int_ext_o = 1'b0;
		mode_init_data_o = 1'b0;
		en_cipher_o = 1'b0;
		en_tag_o = 1'b0;
		en_p_o = 1'b0;
		init_cpt_2_o = 1'b0; 
		en_cpt_2_o = 1'b0;
		end 
	conf_finalisation: begin 
		cipher_valid_o = 1'b0;
		end_o =  1'b0;
		en_cpt_o = 1'b1;
		init_a_o = 1'b0;
		init_b_o = 1'b0;
		data_sel_o = 1'b1;
		bypass_begin_o = 1'b0;
		bypass_end_o = 1'b1;
		mode_int_ext_o = 1'b1;
		mode_init_data_o = 1'b0;
		en_cipher_o = 1'b1;
		en_tag_o = 1'b0;
		en_p_o = 1'b1;
		init_cpt_2_o = 1'b0; 
		en_cpt_2_o = 1'b0;
		end 
	finalisation: begin 
		cipher_valid_o = 1'b0;
		end_o =  1'b0;
		en_cpt_o = 1'b1;
		init_a_o = 1'b0;
		init_b_o = 1'b0;
		data_sel_o = 1'b1;
		bypass_begin_o = 1'b1;
		bypass_end_o = 1'b1;
		mode_int_ext_o = 1'b0;
		mode_init_data_o = 1'b0;
		en_cipher_o = 1'b0;
		en_tag_o = 1'b0;
		en_p_o = 1'b1;
		init_cpt_2_o = 1'b0; 
		en_cpt_2_o = 1'b0;
		end 
	tag_finalisation: begin 
		cipher_valid_o = 1'b0;
		end_o =  1'b0;
		en_cpt_o = 1'b1;
		init_a_o = 1'b0;
		init_b_o = 1'b0;
		data_sel_o = 1'b1;
		bypass_begin_o = 1'b1;
		bypass_end_o = 1'b0;
		mode_int_ext_o = 1'b0;
		mode_init_data_o = 1'b0;
		en_cipher_o = 1'b0;
		en_tag_o = 1'b1;
		en_p_o = 1'b1;
		init_cpt_2_o = 1'b0; 
		en_cpt_2_o = 1'b0;
		end 

	end_finalisation: begin 
		cipher_valid_o = 1'b0;
		end_o =  1'b1;
		en_cpt_o = 1'b0;
		init_a_o = 1'b0;
		init_b_o = 1'b0;
		data_sel_o = 1'b1;
		bypass_begin_o = 1'b1;
		bypass_end_o = 1'b1;
		mode_int_ext_o = 1'b0;
		mode_init_data_o = 1'b0;
		en_cipher_o = 1'b0;
		en_tag_o = 1'b0;
		en_p_o = 1'b0;
		init_cpt_2_o = 1'b0; 
		en_cpt_2_o = 1'b0;
		end 
	default : begin 
		cipher_valid_o = 1'b0;
		end_o =  1'b0;
		en_cpt_o = 1'b0;
		init_a_o = 1'b0;
		init_b_o = 1'b0;
		data_sel_o = 1'b0;
		bypass_begin_o = 1'b1;
		bypass_end_o = 1'b0;
		mode_int_ext_o = 1'b0;
		mode_init_data_o = 1'b0;
		en_cipher_o = 1'b0;
		en_tag_o = 1'b1;
		en_p_o = 1'b0;
		init_cpt_2_o = 1'b0; 
		en_cpt_2_o = 1'b0;
		end 
	endcase ; // case (current_state)
end : comb_1

endmodule : fsm_moore
