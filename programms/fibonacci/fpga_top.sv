`include "../src/parameters.svh"
`define PORT_COUNT (2**`PORT_EXPONENT)

module fpga_top (
    input wire clk, btnC,
    output wire [15:0] led
);

    wire [15:0] port_d_in [0:(`PORT_COUNT*2)-1];
    wire cpu_halt, cpu_read, cpu_write;
    wire [15:0] cpu_addr;
    wire [15:0] port_d_out [0:(`PORT_COUNT*2)-1];
    reg divided_clk;
    wire haltable_clk;
    wire enable_clk;
    wire halt;

    assign led = port_d_out[1];

    cpu cpu (
        .clk (divided_clk),
        .halt (cpu_halt),
        .*
    );

    assign halt = cpu_write ^ btnC;

    assign enable_clk = ~halt;

    always @(posedge clk) begin
        if (halt) begin
            divided_clk = divided_clk;
        end else begin
            divided_clk = ~divided_clk;
        end
    end
endmodule
