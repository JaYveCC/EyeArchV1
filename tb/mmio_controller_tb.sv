`include "src/parameters.svh"
`define PORT_COUNT (2**`PORT_EXPONENT)

module mmio_controller_tb;
    /* verilator lint_off UNUSEDSIGNAL */
    logic clk, read, write;
    logic [15:0] addr, d_in;
    logic [15:0] port_d_in [0:(`PORT_COUNT*2)-1];
    wire [15:0] d_out;
    wire port_inform_write [`PORT_COUNT-1:0];
    wire port_inform_read [`PORT_COUNT-1:0];
    wire [15:0] port_d_out [0:(`PORT_COUNT*2)-1];
    /* verilator lint_on UNUSEDSIGNAL */

    logic [15:0] out_even_stimulus = $random[15:0];
    logic [15:0] out_odd_stimulus = $random[15:0];
    logic [15:0] in_stimulus = $random[15:0];

    /* verilator lint_off UNDRIVEN */
    logic [15:0] out_even_value;
    logic [15:0] out_odd_value;
    /* verilator lint_on UNDRIVEN */

    assign port_d_out[0] = out_even_value;
    assign port_d_out[1] = out_odd_value;

    mmio_controller dut (.*);
    
    initial begin
        forever #40 clk = ~clk;
    end

    initial begin
        $dumpfile("mmio_controller_tb.vcd");
        $dumpvars(0, mmio_controller_tb);

        #100 d_in = out_even_stimulus;
        addr = 0;
        write = 1;
        #100 d_in = out_odd_stimulus;
        addr = 1;
        #100 d_in = 0;
        addr = 0;
        write = 0;

        #100 addr = 4;
        port_d_in[4] = in_stimulus; 
        read = 1;
        #100 addr = 0;
        port_d_in[4] = 0;
        read = 0;
        #100 $finish;
    end
endmodule
