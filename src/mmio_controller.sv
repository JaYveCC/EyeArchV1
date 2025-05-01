`include "../src/parameters.svh"
`define PORT_COUNT (2**`PORT_EXPONENT)

module mmio_controller (
    input logic clk, read, write,
    input logic [15:0] addr, d_in,
    input wire [15:0] port_d_in [0:(`PORT_COUNT*2)-1],
    output logic [15:0] d_out,
    output logic [15:0] port_d_out [0:(`PORT_COUNT*2)-1]
);
    reg [15:0] ram [0:(`PORT_COUNT*2)-1];
    wire [`PORT_EXPONENT:0] port_addr;

    assign port_addr = addr[`PORT_EXPONENT:0];

    initial begin
        $readmemh("../mem/io.mem", ram);
    end

    always @(negedge clk) begin
        if (write && (addr <= `PORT_COUNT*2)) begin
            ram[port_addr] <= d_in;
            if (port_addr[0]) begin
                port_d_out[port_addr] <= d_in;
                port_d_out[port_addr-1] <= ram[port_addr-1];
            end
        end
    end

    always_latch begin
        if (read && (addr <= `PORT_COUNT*2)) begin
            d_out = port_d_in[port_addr];
        end
    end
endmodule
