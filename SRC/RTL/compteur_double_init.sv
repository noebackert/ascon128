//                              -*- Mode: Verilog -*-
// Filename        : compteur_double_init.sv
// Description     : package definition
// Author          : Jean-Baptiste RIGAUD
// Created On      : Sat Oct 14 15:30:30 2023
// Last Modified By: Jean-Baptiste RIGAUD
// Last Modified On: Sat Oct 14 15:30:30 2023
// Update Count    : 0
// Status          : Unknown, Use with caution!
`timescale 1ns/1ps
import ascon_pack::*;
module compteur_double_init (
    input logic 	clock_i,
    input logic 	resetb_i,
    input logic 	en_cpt_i,
    input logic 	init_a_i,
    input logic 	init_b_i,
    output logic [3:0] cpt_o      
    ) ;

   logic [3:0] cpt_s;
   
   always_ff @(posedge clock_i or negedge resetb_i)
     begin
	if (resetb_i == 1'b0) begin
	   cpt_s <= 0;
	end
	else begin 
	   if (en_cpt_i == 1'b1) 
	     begin
		if (init_a_i==1'b1) begin
		   cpt_s<=0;
		end 
		else if (init_b_i==1'b1) begin
		   cpt_s<=6;
		end 
		else cpt_s <= cpt_s+1;
	     end
	end
     end

   assign cpt_o = cpt_s;
   
endmodule: compteur_double_init



