module inst_mux (
    input logic [1:0] inst_type,
    input logic [31:6] inst_operands,
    output logic [4:0] src1, src2, dest, cond,
    output logic [15:0] imm
);
    assign src1 = inst_operands[10:6];
    assign src2 = (inst_type == 2'b01) ? inst_operands[15:11] : 5'b0;
    assign dest = (inst_type == 2'b10) ? (inst_type == 2'b10) ? inst_operands[20:16] : inst_operands[15:11] : 5'b0;
    assign cond = (inst_type == 2'b11) ? inst_operands[15:11] : 5'b0;
    assign imm = (inst_type == 2'b10 | inst_type == 2'b11) ? inst_operands[31:16] : 16'b0;
endmodule
