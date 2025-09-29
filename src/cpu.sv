`include "../src/parameters.svh"
`define PORT_COUNT (2**`PORT_EXPONENT)

module cpu (
    input logic clk, reset,

    input wire [15:0] io_port_d_in [0:(`PORT_COUNT*2)-1],
    input wire interrupt_confirm [0:`INTERRUPT_COUNT-1],
    input wire [15:0] interrupt_id [0:`INTERRUPT_COUNT-1],

    output wire halt, cpu_read, cpu_write, cs_overflow, cs_underflow,
    output wire [15:0] cpu_addr,

    output wire acknowledge [0:`INTERRUPT_COUNT-1],
    output wire [15:0] io_port_d_out [0:(`PORT_COUNT*2)-1]
);
    //prom
    wire [31:0] instruction;

    //controll
    wire alu_c_in, alu_enable, reg_read_a, reg_read_b, reg_write, read_mem, write_mem, push, pop, i_block, update_flags;
    wire [1:0] src_sel, wb_sel, jmp_mode;
    wire [3:0] alu_sel;
    wire [4:0] src1, src2, dest, cond;
    wire [15:0] b_bus, imm;

    //dataloop
    wire [7:0] flags;
    wire [15:0] int_dest;
    
    //pc
    wire [7:0] curent_flags;
    wire [15:0] pc_addr;

    //callstack
    wire cs_full, cs_empty;
    wire [23:0] cs_d_out;

    //interrupt_queue
    wire execute_interrupt;
    wire [15:0] executing_id;

    assign cs_overflow = cs_full & push;
    assign cs_underflow = cs_empty & pop;
    assign cpu_read = read_mem;
    assign cpu_write = write_mem;
    assign cpu_addr = b_bus;

    controll controll (
        .*
    );

    dataloop dataloop (
        .clk (clk),
        .reset (reset),
        .alu_c_in (alu_c_in),
        .alu_enable (alu_enable),
        .alu_sel (alu_sel),
        .reg_read_a (reg_read_a),
        .reg_read_b (reg_read_b),
        .reg_write (reg_write),
        .src_sel (src_sel),
        .dest (dest),
        .src1 (src1),
        .src2 (src2),
        .imm (imm),
        .wb_sel (wb_sel),
        .pc (pc_addr),
        .mem_read (read_mem),
        .mem_write (write_mem),
        .interrupt_id (executing_id),
        .io_port_d_in (io_port_d_in),
        .flags (flags),
        .io_port_d_out (io_port_d_out),
        .b_bus_out (b_bus),
        .int_dest (int_dest)
    );

    prom prom (
        .clk (clk),
        .addr (pc_addr),
        .instruction (instruction)
    );

    pc pc (
        .clk (clk),
        .interrupt (execute_interrupt),
        .pop (pop),
        .update_flags (update_flags),
        .jmp_mode (jmp_mode),
        .cond (cond),
        .flags (flags),
        .cs_flags (cs_d_out[23:16]),
        .jmp_addr (b_bus),
        .cs_addr (cs_d_out[15:0]),
        .interrupt_addr (int_dest),
        .curent_flags (curent_flags),
        .addr (pc_addr)
    );

    callstack callstack (
        .push (push),
        .pop (pop | execute_interrupt),
        .reset (reset),
        .clk (clk),
        .d_in ({pc_addr, curent_flags}),
        .full (cs_full),
        .empty (cs_empty),
        .d_out (cs_d_out)
    );

    interrupt_queue interrupt_queue (
        .clk (clk),
        .reset (reset),
        .i_block (i_block | cs_full),
        .interrupt_confirm (interrupt_confirm),
        .interrupt_id (interrupt_id),
        .execute_interrupt (execute_interrupt),
        .executing_id (executing_id),
        .acknowledge (acknowledge)
    );
endmodule
