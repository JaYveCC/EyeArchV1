module wb_mux (
  input logic [1:0] wb_sel,
  input logic [15:0] mem_in, alu_in, pc,
  output logic [15:0] d_out
);
  always_comb begin
    case (wb_sel)
    2'b00 : d_out = alu_in;
    2'b01 : d_out = mem_in;
    2'b10 : d_out = pc + 1;
    default : d_out = alu_in;
    endcase
  end
endmodule
