module cpu_tb;
    reg clk;
    reg [31:0] instruction;
    /* verilator lint_off UNUSEDSIGNAL */
    wire [15:0] prom_addr;
    /* verilator lint_off UNUSEDSIGNAL */

    cpu dut (
        .clk (clk),
        .instruction (instruction),
        .prom_addr (prom_addr)
    );

    initial begin
        clk = 1'b0;
        forever #50 clk = ~clk;
    end

    initial begin
        $dumpfile("cpu_tb.vcd");
        $dumpvars(0, cpu_tb);
        instruction = 32'b10101010101010100000100000001110;
        #200
        $finish;
    end
endmodule
