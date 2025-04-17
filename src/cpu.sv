`include "src/parameters.svh"
`define PORT_COUNT (2**`PORT_EXPONENT)

module cpu (
    input logic clk,
    input wire [15:0] port_d_in [0:(`PORT_COUNT*2)-1],
    output wire halt,
    output wire port_inform_write [`PORT_COUNT-1:0],
    output wire port_inform_read [`PORT_COUNT-1:0],
    output wire [15:0] port_d_out [0:(`PORT_COUNT*2)-1]
);
    wire [31:0] instruction;
    wire [15:0] prom_addr;

    wire [15:0] a_bus, b_bus, wb_bus;

    //alu
    wire alu_c_out;

    //cu
    wire alu_c_in, alu_enable, reg_read_a, reg_read_b, reg_write, reg_reset, src_sel;
    wire [1:0] inst_type;
    wire [1:0] wb_sel;
    wire [3:0] alu_sel;

    //wb_mux
    wire [15:0] alu_bus, mem_bus;

    //src_mux
    wire [15:0]  b_out_bus, imm_bus;
    
    //inst_mux
    wire [4:0] src1, src2, dest, cond;

    //pc
    wire jmp_true;

    //cond_val_reg
    wire update_flags, cond_c_out;
    wire [15:0] cond_val_bus;

    //bu
    wire jmp, brc;

    //memory
    wire read_mem, write_mem;

    alu alu (
        .c_in (alu_c_in),
        .alu_enable (alu_enable),
        .a_in (a_bus),
        .b_in (b_bus),
        .alu_sel (alu_sel),
        .c_out (alu_c_out),
        .out (alu_bus)
    );

    regfile regfile (
        .clk (clk),
        .read_a (reg_read_a),
        .read_b (reg_read_b),
        .write (reg_write),
        .reset (reg_reset),
        .w_addr (dest),
        .a_addr (src1),
        .b_addr (src2),
        .d_in (wb_bus),
        .a_out (a_bus),
        .b_out (b_out_bus)
    );

    prom prom (
        .clk (clk),
        .addr (prom_addr),
        .instruction (instruction)
    );

    memory memory (
        .clk(clk),
        .read(read_mem),
        .write(write_mem),
        .addr(b_bus),
        .d_in(a_bus),
        .port_d_in(port_d_in),
        .d_out(mem_bus),
        .port_inform_write(port_inform_write),
        .port_inform_read(port_inform_read),
        .port_d_out(port_d_out)
    );

    pc pc (
        .clk (clk),
        .jmp (jmp_true),
        .jmp_addr (b_bus),
        .addr (prom_addr)
    );

    cond_val_reg cond_val_reg (
        .clk (clk),
        .update_flags (update_flags),
        .c_out (alu_c_out),
        .wb_bus (wb_bus),
        .cond_c_out (cond_c_out),
        .cond_val_out (cond_val_bus)
    );

    bu bu (
        .jmp (jmp),
        .brc (brc),
        .c_out (cond_c_out),
        .cond (cond),
        .wb_val (cond_val_bus),
        .jmp_true (jmp_true)
    );

    wb_mux wb_mux (
        .wb_sel (wb_sel),
        .alu_in (alu_bus),
        .mem_in (mem_bus),
        .pc (prom_addr),
        .d_out (wb_bus)
    );

    src_mux src_mux (
        .src_sel (src_sel),
        .b_in (b_out_bus),
        .imm (imm_bus),
        .d_out (b_bus)
    );

    inst_mux inst_mux (
        .inst_type (inst_type),
        .inst_operands (instruction[31:6]),
        .src1 (src1),
        .src2 (src2),
        .dest (dest),
        .cond (cond),
        .imm (imm_bus)
    );

    cu cu (
        .opcode (instruction[5:0]),
        .*
        );
endmodule
