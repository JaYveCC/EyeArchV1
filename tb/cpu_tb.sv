module cpu_tb;
    /* verilator lint_off UNDRIVEN */
    /* verilator lint_off UNUSEDSIGNAL */
    reg clk = 1'b0;
    reg [15:0] port_d_in [0:(`PORT_COUNT*2)-1];
    reg halt;
    wire port_inform_write [`PORT_COUNT-1:0];
    wire port_inform_read [`PORT_COUNT-1:0];
    wire [15:0] port_d_out [0:(`PORT_COUNT*2)-1];
    /* verilator lint_on UNDRIVEN */
    /* verilator lint_on UNUSEDSIGNAL */

    int count;

    cpu dut (
        .*
    );

    assign port_d_in[0] = 10;

    initial begin
        $dumpfile("cpu_tb.vcd");
        $dumpvars(0, cpu_tb);

        while (halt == 0) begin
            #40 clk = ~clk;
            count++;
            if (count >= 100) $finish;
        end
    end
endmodule
