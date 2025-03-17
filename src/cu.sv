module cu (
    input logic [5:0] opcode,
    output logic alu_c_in, alu_enable, reg_read_a, reg_read_b, reg_write, reg_reset,
    output logic [1:0] inst_type,
    output logic [2:0] src_sel,
    output logic [3:0] alu_sel
);
    always @(opcode) begin
    case (opcode)
        6'b000001 : begin   //ADD  
            inst_type <= 2'b01;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b0000;
            reg_read_a <= 1; reg_read_b <= 1; reg_write <= 1; reg_reset <= 0;
            src_sel <= 3'b000;
        end
        6'b000010 : begin   //SUB
            inst_type <= 2'b01;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b0001;
            reg_read_a <= 1; reg_read_b <= 1; reg_write <= 1; reg_reset <= 0;
            src_sel <= 3'b000;
        end
        6'b000011 : begin   //OR
            inst_type <= 2'b01;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b0010;
            reg_read_a <= 1; reg_read_b <= 1; reg_write <= 1; reg_reset <= 0;
            src_sel <= 3'b000;
        end
        6'b000100 : begin   //AND
            inst_type <= 2'b01;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b0011;
            reg_read_a <= 1; reg_read_b <= 1; reg_write <= 1; reg_reset <= 0;
            src_sel <= 3'b000;
        end
        6'b000101 : begin   //XOR
            inst_type <= 2'b01;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b0100;
            reg_read_a <= 1; reg_read_b <= 1; reg_write <= 1; reg_reset <= 0;
            src_sel <= 3'b000;
        end
        6'b000110 : begin   //NOR
            inst_type <= 2'b01;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b0101;
            reg_read_a <= 1; reg_read_b <= 1; reg_write <= 1; reg_reset <= 0;
            src_sel <= 3'b000;
        end
        6'b000111 : begin   //NAND
            inst_type <= 2'b01;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b0110;
            reg_read_a <= 1; reg_read_b <= 1; reg_write <= 1; reg_reset <= 0;
            src_sel <= 3'b000;
        end
        6'b001000 : begin   //XNOR
            inst_type <= 2'b01;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b0111;
            reg_read_a <= 1; reg_read_b <= 1; reg_write <= 1; reg_reset <= 0;
            src_sel <= 3'b000;
        end
        6'b001001 : begin   //INV
            inst_type <= 2'b01;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b1100;
            reg_read_a <= 1; reg_read_b <= 0; reg_write <= 1; reg_reset <= 0;
            src_sel <= 3'b000;
        end
        6'b001010 : begin   //BSHL
            inst_type <= 2'b01;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b1001;
            reg_read_a <= 1; reg_read_b <= 1; reg_write <= 1; reg_reset <= 0;
            src_sel <= 3'b000;
        end
        6'b001011 : begin   //BSHR
            inst_type <= 2'b01;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b1000;
            reg_read_a <= 1; reg_read_b <= 1; reg_write <= 1; reg_reset <= 0;
            src_sel <= 3'b000;
        end
        6'b001100 : begin   //SBSHL
            inst_type <= 2'b01;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b1010;
            reg_read_a <= 1; reg_read_b <= 1; reg_write <= 1; reg_reset <= 0;
            src_sel <= 3'b000;
        end
        6'b001101 : begin   //SBSHR
            inst_type <= 2'b01;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b1011;
            reg_read_a <= 1; reg_read_b <= 1; reg_write <= 1; reg_reset <= 0;
            src_sel <= 3'b000;
        end
        6'b001110 : begin   //LDIM
            inst_type <= 2'b10;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b0010;
            reg_read_a <= 0; reg_read_b <= 0; reg_write <= 1; reg_reset <= 0;
            src_sel <= 3'b001;
        end
        6'b001111 : begin   //ADDI
            inst_type <= 2'b10;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b0000;
            reg_read_a <= 1; reg_read_b <= 0; reg_write <= 1; reg_reset <= 0;
            src_sel <= 3'b001;
        end
        default : begin     //NOP
            inst_type <= 2'b00;
            alu_c_in <= 0; alu_enable <= 0;
            alu_sel <= 4'b0000;
            reg_read_a <= 0; reg_read_b <= 0; reg_write <= 0; reg_reset <= 0;
            src_sel <= 3'b000;
        end
    endcase
  end
endmodule
