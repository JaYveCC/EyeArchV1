`include "../src/parameters.svh"
`define PORT_COUNT (2**`PORT_EXPONENT)

module fpga_top (
    input wire clk, btnR, btnL,
    input wire [15:0] sw,
    output wire [15:0] led
);
    reg btnL_dly, btnR_dly;

    wire divided_clk;

    wire [15:0] io_port_d_in [0:(`PORT_COUNT*2)-1];
    reg interrupt_confirm [0:`INTERRUPT_COUNT-1];
    reg [15:0] interrupt_id [0:`INTERRUPT_COUNT-1];

    wire halt, cpu_read, cpu_write, cs_overflow, cs_underflow;
    wire [15:0] cpu_addr;

    wire acknowledge [0:`INTERRUPT_COUNT-1];
    wire [15:0] io_port_d_out [0:(`PORT_COUNT*2)-1];

    assign led = io_port_d_out[1];
    assign io_port_d_in[1] = sw;

    assign interrupt_id[0] = 16'b0;
    assign interrupt_id[1] = 16'b1;

    assign btnL_posedge = btnL & ~btnL_dly;
    assign btnR_posedge = btnR & ~btnR_dly;

    always_ff @(posedge divided_clk) begin
        btnL_dly <= btnL;
        btnR_dly <= btnR;

        if (btnL_posedge) begin
            interrupt_confirm[0] <= 1'b1;
        end
        
        if (btnR_posedge) begin
            interrupt_confirm[1] <= 1'b1;
        end
        
        if (acknowledge[0]) begin
            interrupt_confirm[0] <= 1'b0;
        end
        
        if (acknowledge[1]) begin
            interrupt_confirm[1] <= 1'b0;
        end
    end

    cpu cpu (
        .clk (divided_clk),
        .io_port_d_in (io_port_d_in),
        .interrupt_confirm (interrupt_confirm),
        .interrupt_id (interrupt_id),
        .halt (halt),
        .cpu_read (cpu_read),
        .cpu_write (cpu_write),
        .cs_overflow (cs_overflow),
        .cs_underflow (cs_underflow),
        .cpu_addr (cpu_addr),
        .acknowledge (acknowledge),
        .io_port_d_out (io_port_d_out)
    );
    
    clk_divider clk_divider (
        .divided_clk(divided_clk),
        .clk_in(clk)
    );
endmodule
