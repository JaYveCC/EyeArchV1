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
        $dumpfile("cpu_tb.vcd");
        $dumpvars(0, cpu_tb);
        clk = 1'b1;
        instruction = 32'b00000000000000110000100000001110;
        #50
        clk = 1'b0;
        #50
        clk = 1'b1;
        instruction = 32'b00000000000001110001000000001110;
        #50
        clk = 1'b0;
        #50
        clk = 1'b1;
        instruction = 32'b00000000000000110001000001000001;
        #50
        clk = 1'b0;
        #50
        $finish;
    end
endmodule
