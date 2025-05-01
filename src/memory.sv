`include "../src/parameters.svh"
`define PORT_COUNT (2**`PORT_EXPONENT)

module memory (
    input wire clk, read, write,
    input wire [15:0] addr, d_in,
    input wire [15:0] port_d_in [0:(`PORT_COUNT*2)-1],
    output wire [15:0] d_out,
    output wire [15:0] port_d_out [0:(`PORT_COUNT*2)-1]
);
    wire [15:0] ram_d_out;
    wire [15:0] mmio_d_out;

    dram dram (
        .clk(clk),
        .read(read),
        .write(write),
        .addr(addr),
        .d_in(d_in),
        .d_out(ram_d_out)
    );

    mmio_controller mmio_controller (
        .clk(clk),
        .read(read),
        .write(write),
        .addr(addr),
        .d_in(d_in),
        .port_d_in(port_d_in),
        .d_out(mmio_d_out),
        .port_d_out(port_d_out)
    );

    assign d_out = ram_d_out | mmio_d_out;
endmodule
