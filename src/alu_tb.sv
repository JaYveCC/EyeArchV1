module alu_tb ();
reg c_in;
reg [15:0] a_in, b_in;
reg [3:0] alu_sel;
/* verilator lint_off UNUSEDSIGNAL */
wire c_out;
wire [15:0] out;
/* verilator lint_off UNUSEDSIGNAL */

alu dut (
.c_in (c_in),
.a_in (a_in),
.b_in (b_in),
.alu_sel (alu_sel),
.c_out (c_out),
.out (out)
);

initial begin
   $dumpfile("alu_tb.vcd");
   $dumpvars(0, alu_tb);
   a_in = 16'b1001;
   b_in = 16'b111;
   c_in = 1'b1;
   alu_sel = 4'b0;
   #20
   a_in = 16'b01011;
   b_in = 16'b110;
   c_in = 1'b1;
   alu_sel = 4'b1;
   #20
   a_in = 16'b1101;
   b_in = 16'b101;
   c_in = 1'b0;
   alu_sel = 4'b0;
   #20
   a_in = 16'b1111111111111111;
   b_in = 16'b1111111111111111;
   c_in = 1'b1;
   alu_sel = 4'b0;
   #20
   $monitor("done");
end
endmodule
