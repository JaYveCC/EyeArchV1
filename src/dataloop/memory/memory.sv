`include "src/parameters.svh"
`define PORT_COUNT (2**`PORT_EXPONENT)

module memory (
    input wire clk, read, write,
    input wire [15:0] addr, d_in, interrupt_id,
    input wire [15:0] port_d_in [0:(`PORT_COUNT*2)-1],
    output wire [15:0] d_out,
    output reg [15:0] int_dest,
    output wire [15:0] port_d_out [0:(`PORT_COUNT*2)-1]
);
    wire [15:0] ram_d_out;
    wire [15:0] mmio_d_out;

    always_ff @(negedge clk) begin
        if (addr == `CSR_INT_DEST && read) begin
            int_dest <= d_in;
        end
    end

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

    assign d_out = (addr == `CSR_INT_ID) ? interrupt_id : ram_d_out | mmio_d_out;
endmodule
