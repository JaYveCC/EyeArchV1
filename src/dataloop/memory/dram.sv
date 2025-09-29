`include "../src/parameters.svh"
`define PORT_COUNT (2**`PORT_EXPONENT)

module dram (
    input logic clk, read, write,
    input logic [15:0] addr, d_in,
    output logic [15:0] d_out
);
    reg [15:0] ram [(`PORT_COUNT*2):2000];

    initial begin
        $readmemh("../mem/ram.mem", ram);
    end

    always @(negedge clk) begin
        if (write) begin
            ram[addr] <= d_in;
        end
    end

    always_comb begin
        d_out = 16'b0;
        if (read) begin
            d_out = ram[addr];
        end
    end
endmodule
