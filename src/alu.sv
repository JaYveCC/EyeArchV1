module alu (
  input logic c_in, alu_enable,
  input logic [15:0] a_in, b_in,
  input logic [3:0] alu_sel,
  output logic c_out,
  output logic [15:0] out
);
  always @(*) begin
    out = 0;
    c_out = 1'b0;
    if (alu_enable) begin
      case (alu_sel)
      4'b0000 : {c_out,out} = a_in + b_in + {15'b0,c_in};
      4'b0001 : {c_out,out} = a_in - b_in + {15'b0,c_in};
      4'b0010 : out = a_in | b_in;
      4'b0011 : out = a_in & b_in;
      4'b0100 : out = a_in ^ b_in;
      4'b0101 : out = a_in ~| b_in;
      4'b0110 : out = a_in ~& b_in;
      4'b0111 : out = a_in ~^ b_in;
      4'b1000 : out = a_in << b_in;
      4'b1001 : out = a_in >> b_in;
      4'b1010 : out = a_in <<< b_in;
      4'b1011 : out = a_in >>> b_in;
      4'b1100 : out = ~a_in;
      4'b1101 : {c_out,out} = b_in - a_in + {15'b0,c_in};
      default: out = a_in | b_in;
      endcase
    end
  end
endmodule
