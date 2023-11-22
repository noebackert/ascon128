`timescale 1ns/1ps

import ascon_pack::*;

module pl(
    input type_state plin_i, 
    output type_state plout_o
);

type_state inter1, inter2;

rotation #(.N(19)) rot_mod0 (
    .rot_i(plin_i[0]),
    .rot_o(inter1[0])
);
rotation #(.N(28)) rot_mod0_2 (
    .rot_i(plin_i[0]),
    .rot_o(inter2[0])
);
rotation #(.N(61)) rot_mod1 (
    .rot_i(plin_i[1]),
    .rot_o(inter1[1])
);
rotation #(.N(39)) rot_mod1_2 (
    .rot_i(plin_i[1]),
    .rot_o(inter2[1])
);
rotation #(.N(1)) rot_mod2 (
    .rot_i(plin_i[2]),
    .rot_o(inter1[2])
);

rotation #(.N(6)) rot_mod2_2 (
    .rot_i(plin_i[2]),
    .rot_o(inter2[2])
);
rotation #(.N(10)) rot_mod3 (
    .rot_i(plin_i[3]),
    .rot_o(inter1[3])
);
rotation #(.N(17)) rot_mod3_2 (
    .rot_i(plin_i[3]),
    .rot_o(inter2[3])
);
rotation #(.N(7)) rot_mod4(
    .rot_i(plin_i[4]),
    .rot_o(inter1[4])
);
rotation #(.N(41)) rot_mod4_2 (
    .rot_i(plin_i[4]),
    .rot_o(inter2[4])
);

genvar i;
generate


	for (i = 0; i < 5 ; i++) begin : label1
	    assign plout_o[i] = plin_i[i] ^ inter1[i] ^ inter2[i];
end
endgenerate
endmodule : pl


