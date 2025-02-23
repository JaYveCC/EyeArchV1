module prom_tb;
    reg read;
    reg [15:0] addr;
    /* verilator lint_off UNUSEDSIGNAL */
    wire [31:0] instruction;
    /* verilator lint_off UNUSEDSIGNAL */
    
    prom dut (
        .read (read),
        .addr (addr),
        .instruction (instruction)
    );

    initial begin
        $dumpfile("prom_tb.vcd");
        $dumpvars(0, prom_tb);

        read = 1'b1;
        addr = 16'b0;
        #40
        addr = 16'b1;
        #40
        addr = 16'b10;
        #40
        addr = 16'b11;
        #40
        addr = 16'b100;
        #40
        $finish;
    end
endmodule
