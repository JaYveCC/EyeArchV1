module src_mux (
  input logic [1:0] src_sel,
  input logic [15:0] b_in, imm,
  output logic [15:0] d_out
);
  always_comb begin
    case (src_sel)
    2'b00 : d_out = b_in;
    2'b01 : d_out = imm;
    default: d_out = b_in;
    endcase
  end
endmodule
