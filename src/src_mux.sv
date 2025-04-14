module src_mux (
  input logic [1:0] src_sel,
  input logic [15:0] b_in, imm, pc,
  output logic [15:0] d_out
);
  always @(*) begin
    case (src_sel)
    2'b00 : d_out = b_in;
    2'b01 : d_out = imm;
    2'b10 : d_out = pc;
    default: d_out = b_in;
    endcase
  end
endmodule
