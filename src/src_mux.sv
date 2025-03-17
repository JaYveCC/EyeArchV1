module src_mux (
    input logic [2:0] src_sel,
    input logic [15:0] b_in, imm, mem_in, io_in, pc, sp,
    output logic [15:0] d_out
);
    always @(*) begin
      case (src_sel)
      3'b000 : d_out = b_in;
      3'b001 : d_out = imm;
      3'b010 : d_out = mem_in;
      3'b011 : d_out = io_in;
      3'b100 : d_out = pc;
      3'b101 : d_out = sp;
      default: d_out = b_in;
      endcase
  end
endmodule
