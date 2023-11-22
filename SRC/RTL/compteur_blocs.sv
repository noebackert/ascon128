`timescale 1ns/1ps
import ascon_pack::*;

module compteur_blocs (
    input logic clock_i,
    input logic resetb_i,
    input logic en_blocs_i,
    input logic init_i,
    output logic [1:0] cpt_blocs_o      
    ) ;

   logic [1:0] cpt_blocs_s;
   
   always_ff @(posedge clock_i or negedge resetb_i)
     begin
	if (resetb_i == 1'b0) begin
	   cpt_blocs_s <= 0;
	end
	else begin 
	   if (en_blocs_i == 1'b1) 
	     begin
		if (init_i==1'b1) begin
		   cpt_blocs_s <= cpt_blocs_s+1;
		end  
	     end
	end
     end

   assign cpt_blocs_o = cpt_blocs_s;
   
endmodule: compteur_blocs



