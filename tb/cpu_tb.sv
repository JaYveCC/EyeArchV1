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

    cpu dut (
        .*
    );

    assign port_d_in[0] = 16'b1010101;
    assign port_d_in[1] = 16'b1100110;

    initial begin
        $dumpfile("cpu_tb.vcd");
        $dumpvars(0, cpu_tb);

        for (int i = 0; i < 50; i++) begin
            #40 clk = ~clk;
        end
    end
endmodule
