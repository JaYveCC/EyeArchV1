module cpu (
    input logic clk,
    input logic [31:0] instruction,
    /* verilator lint_off UNDRIVEN */
    output logic [15:0] prom_addr
    /* verilator lint_off UNDRIVEN */
);
    wire [15:0] a_bus, b_bus, wb_bus;
    /* verilator lint_off UNUSEDSIGNAL */
    wire alu_c_out;

    //cu
    reg [31:0] ir;
    wire alu_c_in, alu_enable, reg_read_a, reg_read_b, reg_write, reg_reset;
    wire [1:0] inst_type;
    wire [2:0] wb_sel;
    wire [3:0] alu_sel;

    //wb_mux
    wire [15:0] alu_bus, imm_bus, mem_bus, io_bus, pc, sp;
    
    //inst_mux
    wire [4:0] src1, src2, dest, cond;
    /* verilator lint_off UNUSEDSIGNAL */

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
        .b_out (b_bus)
    );

    wb_mux wb_mux (
        .wb_sel (wb_sel),
        .alu_in (alu_bus),
        .imm (imm_bus),
        .mem_in (mem_bus),
        .io_in (io_bus),
        .pc (pc),
        .sp (sp),
        .d_out (wb_bus)
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
