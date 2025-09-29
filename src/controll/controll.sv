module controll (
    input logic [31:0] instruction,

    output logic alu_c_in, alu_enable, reg_read_a, reg_read_b, reg_write, read_mem, write_mem, push, pop, i_block, update_flags, halt,
    output logic [1:0] src_sel, wb_sel, jmp_mode,
    output logic [3:0] alu_sel,

    output logic [4:0] src1, src2, dest, cond,
    output logic [15:0] imm
);

    //inst_decoder
    wire [1:0] inst_type;

    operand_splitter operand_splitter (
        .inst_type (inst_type),
        .inst_operands (instruction[31:6]),
        .src1 (src1),
        .src2 (src2),
        .dest (dest),
        .cond (cond),
        .imm (imm)
    );

    inst_decoder inst_decoder (
        .opcode (instruction[5:0]),
        .*
    );
endmodule
