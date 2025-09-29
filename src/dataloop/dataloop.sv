`include "../src/parameters.svh"
`define PORT_COUNT (2**`PORT_EXPONENT)

module dataloop (
    input wire clk, reset,

    input wire alu_c_in, alu_enable,
    inout wire [3:0] alu_sel,

    input wire reg_read_a, reg_read_b, reg_write,
    input wire [1:0] src_sel,
    input wire [4:0] dest, src1, src2,
    input wire [15:0] imm,

    input wire [1:0] wb_sel,
    input wire [15:0] pc,

    input wire mem_read, mem_write,
    input wire [15:0] interrupt_id,
    input wire [15:0] io_port_d_in [0:(`PORT_COUNT*2)-1],

    output wire [7:0] flags,
    output wire [15:0] io_port_d_out [0:(`PORT_COUNT*2)-1],

    output wire [15:0] b_bus_out, int_dest
);  

    //alu
    wire alu_c_out;
    wire [15:0] alu_out;

    //regfile
    wire [15:0] a_bus, reg_b_out;

    //memory
    wire [15:0] mem_d_out;

    //src_mux
    wire [15:0] b_bus;

    //wb_mux
    wire [15:0] wb_bus;

    assign b_bus_out = b_bus;
    
    alu alu (
        .c_in (alu_c_in),
        .alu_enable (alu_enable),
        .a_in (a_bus),
        .b_in (b_bus),
        .alu_sel (alu_sel),
        .c_out (alu_c_out),
        .out (alu_out)
    );

    flag_unit flag_unit (
        .c_out (alu_c_out),
        .wb_val (wb_bus),
        .flags (flags)
    );

    regfile regfile (
        .clk (clk),
        .read_a (reg_read_a),
        .read_b (reg_read_b),
        .write (reg_write),
        .reset (reset),
        .w_addr (dest),
        .a_addr (src1),
        .b_addr (src2),
        .d_in (wb_bus),
        .a_out (a_bus),
        .b_out (reg_b_out)
    );

    memory memory (
        .clk(clk),
        .read(mem_read),
        .write(mem_write),
        .addr(b_bus),
        .d_in(a_bus),
        .interrupt_id(interrupt_id),
        .port_d_in(io_port_d_in),
        .d_out(mem_d_out),
        .int_dest(int_dest),
        .port_d_out(io_port_d_out)
    );

    wb_mux wb_mux (
        .wb_sel (wb_sel),
        .alu_in (alu_out),
        .mem_in (mem_d_out),
        .pc (pc),
        .d_out (wb_bus)
    );

    src_mux src_mux (
        .src_sel (src_sel),
        .b_in (reg_b_out),
        .imm (imm),
        .d_out (b_bus)
    );
endmodule
