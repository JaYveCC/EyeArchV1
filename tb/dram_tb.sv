module dram_tb;
    reg clk = 1'b1;
    reg read, write;
    /* verilator lint_off UNUSEDSIGNAL */
    reg [15:0] addr, d_in, d_out;
    /* verilator lint_on UNUSEDSIGNAL */
    
    dram dut (
        .clk (clk),
        .read (read),
        .write (write),
        .addr (addr),
        .d_in (d_in),
        .d_out (d_out)
    );

    initial begin
        $dumpfile("dram_tb.vcd");
        $dumpvars(0, prom_tb);
        clk = 1'b0;
        read = 1'b1;
        write = 1'b0;
        addr = 16'b0;
        #40
        clk = 1'b1;
        #40
        clk = 1'b0;
        write = 1'b1;
        read = 1'b0;
        addr = 16'b1;
        d_in = 16'b1010101010101010;
        #40
        clk = 1'b1;
        #40
        clk = 1'b0;
        read = 1'b1;
        write = 1'b0;
        addr = 16'b10;
        #40
        clk = 1'b1;
        #40
        $finish;
    end
endmodule
