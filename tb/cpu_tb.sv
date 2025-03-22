module cpu_tb;
    reg clk = 1'b0;

    cpu dut (
        .clk (clk)
    );

    initial begin
        $dumpfile("cpu_tb.vcd");
        $dumpvars(0, cpu_tb);
        for (int i = 0; i < 50; i++) begin
            #40 clk = ~clk;
        end
    end
endmodule
