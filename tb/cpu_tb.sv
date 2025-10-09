`include "../src/parameters.svh"
`define PORT_COUNT (2**`PORT_EXPONENT)

module cpu_tb;
    /* verilator lint_off UNDRIVEN */
    /* verilator lint_off UNUSEDSIGNAL */
    reg clk = 1'b0;
    reg reset = 1'b0;
    reg [15:0] io_port_d_in [0:(`PORT_COUNT*2)-1];
    reg interrupt_confirm [0:`INTERRUPT_COUNT-1];
    reg [15:0] interrupt_id [0:`INTERRUPT_COUNT-1];

    wire halt, cpu_read, cpu_write, cs_overflow, cs_underflow;
    wire [15:0] cpu_addr;
    wire [15:0] io_port_d_out [0:(`PORT_COUNT*2)-1];
    wire acknowledge [0:`INTERRUPT_COUNT-1];
    /* verilator lint_on UNDRIVEN */
    /* verilator lint_on UNUSEDSIGNAL */

    int count;

    cpu dut (
        .*
    );

    assign io_port_d_in[0] = 10;

    initial begin
        $dumpfile("cpu_tb.vcd");
        $dumpvars(0, cpu_tb);

        while (halt == 0) begin
            #40 clk = ~clk;
            count++;
            if (count >= 10000) $finish;
        end
    end

    initial begin
        #4000
        interrupt_id[5] = 16'b101;
        interrupt_confirm[5] = 1'b1;
        #40
        interrupt_confirm[5] = 1'b0;
    end
endmodule
