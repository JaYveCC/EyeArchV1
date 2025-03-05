module cpu_tb;
    reg clk = 1'b0;
    reg reset = 1'b0;

    cpu dut (
        .clk (clk),
        .reset (reset)
    );

    initial begin
        $dumpfile("cpu_tb.vcd");
        $dumpvars(0, cpu_tb);
        /* verilator lint_off INFINITELOOP */
        forever clk = ~clk;
        /* verilator lint_off INFINITELOOP */
    end
endmodule
