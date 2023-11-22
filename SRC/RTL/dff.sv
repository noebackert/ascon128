`timescale 1ns/1ps
import ascon_pack::*;
module dff (
input logic clock_i , resetb_i, enable_i ,
input type_state d_i,
output type_state q_o
);

always_ff @( posedge clock_i or negedge resetb_i )
begin :seq_0
if ( resetb_i == 0)
    q_o <= 0;
else if (enable_i == 1)
    q_o <= d_i ;
end : seq_0
endmodule : dff
