module inst_mux (
    input logic [1:0] inst_type,
    input logic [31:6] inst_operands,
    output logic [4:0] src1, src2, dest, cond,
    output logic [15:0] imm
);

    always @(*) begin
        case (inst_type)
            2'b01 : begin   //S-type
                src1 = inst_operands[10:6];
                src2 = inst_operands[15:11];
                dest = inst_operands[20:16];
                cond = 5'b0;
                imm = 16'b0;
            end
            2'b10 : begin   //I-type
                src1 = inst_operands[10:6];
                src2 = 5'b0;
                dest = inst_operands[15:11];
                cond = 5'b0;
                imm = inst_operands[31:16];
            end
            2'b11 : begin   //B-type
                src1 = inst_operands[10:6];
                src2 = 5'b0;
                dest = 5'b0;
                cond = inst_operands[15:11];
                imm = inst_operands[31:16];
            end
            default: begin
                src1 = 5'b0;
                src2 = 5'b0;
                dest = 5'b0;
                cond = 5'b0;
                imm = 16'b0;
            end
        endcase
    end
endmodule
