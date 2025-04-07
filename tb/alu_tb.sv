module alu_tb ();
reg c_in, alu_enable;
reg [15:0] a_in, b_in;
reg [3:0] alu_sel;
/* verilator lint_off UNUSEDSIGNAL */
wire c_out;
wire [15:0] out;
/* verilator lint_on UNUSEDSIGNAL */

alu dut (
.c_in (c_in),
.alu_enable (alu_enable),
.a_in (a_in),
.b_in (b_in),
.alu_sel (alu_sel),
.c_out (c_out),
.out (out)
);

initial begin
   $dumpfile("alu_tb.vcd");
   $dumpvars(0, alu_tb);

   alu_sel = 4'b1111;
   alu_enable = 1'b1;
   
   for (int i = 0; i < 16; i++) begin
		alu_sel = alu_sel + 4'b0001;
      /* verilator lint_off WIDTHTRUNC */
      a_in = $random;
      b_in = $random;
      c_in = $random;
      /* verilator lint_off WIDTHTRUNC */
      #20
      $display(i);
   end
   $display("done");
end
endmodule
