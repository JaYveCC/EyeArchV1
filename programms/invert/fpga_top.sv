`include "../src/parameters.svh"
`define PORT_COUNT (2**`PORT_EXPONENT)

module fpga_top (
    input wire clk,
    input wire [15:0] sw,
    output wire [15:0] led
);

    wire [15:0] port_d_in [0:(`PORT_COUNT*2)-1];
    wire halt;
    wire port_inform_write [`PORT_COUNT-1:0];
    wire port_inform_read [`PORT_COUNT-1:0];
    wire [15:0] port_d_out [0:(`PORT_COUNT*2)-1];
    reg divided_clk = 1'b0;

    assign port_d_in[1] = sw;
    assign led = port_d_out[1];

    cpu cpu (
        .clk (divided_clk),
        .*
    );

    always @ (posedge clk) begin
        divided_clk = ~divided_clk;
    end
endmodule
