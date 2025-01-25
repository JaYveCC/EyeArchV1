module alu_tb ();
reg c_in;
reg [7:0] a_in, b_in;
reg [3:0] alu_sel;
/* verilator lint_off UNUSEDSIGNAL */
wire c_out;
wire [7:0] out;
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
   a_in = 8'b1001;
   b_in = 8'b111;
   c_in = 1'b1;
   alu_sel = 4'b0;
   #20
   a_in = 8'b01011;
   b_in = 8'b110;
   c_in = 1'b1;
   alu_sel = 4'b1;
   #20
   a_in = 8'b1101;
   b_in = 8'b101;
   c_in = 1'b0;
   alu_sel = 4'b0;
   #20
   a_in = 8'b11111111;
   b_in = 8'b11111111;
   c_in = 1'b1;
   alu_sel = 4'b0;
   #20
   $monitor("done");
end
endmodule
