module wb_mux (
  input logic wb_sel,
  input logic [15:0] mem_in, alu_in,
  output logic [15:0] d_out
);
  always @(*) begin
    case (wb_sel)
    1'b0 : d_out = alu_in;
    1'b1 : d_out = mem_in;
    default : d_out = alu_in;
    endcase
  end
endmodule
