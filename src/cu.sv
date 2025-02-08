module cu (
    input logic [5:0] opcode,
    output logic alu_c_in, alu_enable, reg_read_a, reg_read_b, reg_write, reg_reset,
    output logic [1:0] inst_type,
    output logic [2:0] wb_sel,
    output logic [3:0] alu_sel
);
    always @(opcode) begin
    case (opcode)
        6'b001110 : begin     //LDIM
            inst_type <= 2'b10;
            alu_c_in <= 0; alu_enable <= 0;
            alu_sel <= 4'b0000;
            reg_read_a <= 0; reg_read_b <= 0; reg_write <= 1; reg_reset <= 0;
            wb_sel <= 3'b001;
        end
        default : begin     //NOP
            inst_type <= 2'b00;
            alu_c_in <= 0; alu_enable <= 0;
            alu_sel <= 4'b0000;
            reg_read_a <= 0; reg_read_b <= 0; reg_write <= 0; reg_reset <= 0;
            wb_sel <= 3'b000;
        end
    endcase
  end
endmodule
