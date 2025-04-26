module src_mux (
  input logic src_sel,
  input logic [15:0] b_in, imm,
  output logic [15:0] d_out
);
  always_comb begin
    case (src_sel)
    1'b0 : d_out = b_in;
    1'b1 : d_out = imm;
    default: d_out = b_in;
    endcase
  end
endmodule
