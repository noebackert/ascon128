`timescale 1ns/1ps
module dffN_tb
(
);
logic clock_s , resetb_s, enable_s;
logic[63:0] d_s, q_s;

dffN  #(.N(64)) DUT(
	.d_i (d_s) ,
	.resetb_i (resetb_s) ,
	.clock_i (clock_s) ,
	.q_o (q_s),
	.enable_i(enable_s)
);

initial
begin
clock_s = 0;
forever #5 clock_s = ~ clock_s ;
end// stimuli
initial
begin
resetb_s = 1;
enable_s = 1;
d_s = 64'h1000000000000000;
#12;
d_s = 64'h2000000000000000;
#23;
d_s = 64'h3000000000000000;
#12
enable_s = 0;
d_s = 64'h4000000000000000;
#50;
resetb_s = 0;
#50;
end
endmodule : dffN_tb
