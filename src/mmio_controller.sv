`include "../src/parameters.svh"
`define PORT_COUNT (2**`PORT_EXPONENT)

module mmio_controller (
    input logic clk, read, write,
    input logic [15:0] addr, d_in,
    input wire [15:0] port_d_in [0:(`PORT_COUNT*2)-1],
    output logic [15:0] d_out,
    output wire port_inform_write [`PORT_COUNT-1:0],
    output wire port_inform_read [`PORT_COUNT-1:0],
    output logic [15:0] port_d_out [0:(`PORT_COUNT*2)-1]
);
    reg [15:0] ram [0:(`PORT_COUNT*2)-1];
    wire [`PORT_EXPONENT:0] port_addr;

    logic port_inform_read_logic [`PORT_COUNT-1:0];
    logic port_inform_write_logic [`PORT_COUNT-1:0];

    assign port_inform_read = port_inform_read_logic;
    assign port_inform_write = port_inform_write_logic;

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

    always @(posedge clk) begin
        port_inform_read_logic[port_addr[`PORT_EXPONENT:1]] <= 1'b0;
        port_inform_write_logic[port_addr[`PORT_EXPONENT:1]] <= 1'b0;
    end

    always_latch begin
        if (read && (addr <= `PORT_COUNT*2)) begin
            d_out = port_d_in[port_addr];
            port_inform_read_logic[port_addr[`PORT_EXPONENT:1]] = 1'b1;
        end

        if (write && port_addr[0] && (addr <= `PORT_COUNT*2)) begin
            port_inform_write_logic[port_addr[`PORT_EXPONENT:1]] = 1'b1;
        end
    end
endmodule
