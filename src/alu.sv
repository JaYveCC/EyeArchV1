module alu (
  input logic c_in,
  input logic [7:0] a_in, b_in,
  input logic [3:0] alu_sel,
  output logic c_out,
  output logic [7:0] out
);

  always_comb begin
    case (alu_sel)
      4'b0 : {c_out,out} = a_in + b_in + {7'b0,c_in};
      default: out = a_in | b_in;
    endcase
  end
endmodule
