module inst_decoder (
    input logic [5:0] opcode,
    output logic alu_c_in, alu_enable, reg_read_a, reg_read_b, reg_write, read_mem, write_mem, push, pop, i_block, update_flags, halt,
    output logic [1:0] inst_type, src_sel, wb_sel, jmp_mode,
    output logic [3:0] alu_sel
);
    always @(opcode) begin
    case (opcode)
        6'b000001 : begin   //ADD  
            inst_type <= 2'b01;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b0000;
            reg_read_a <= 1; reg_read_b <= 1; reg_write <= 1;
            src_sel <= 2'b00;
            wb_sel <= 2'b00;
            read_mem <= 1'b0;
            write_mem <= 1'b0;
            jmp_mode <= 2'b00;
            push <= 1'b0;
            pop <= 1'b0;
            update_flags <= 1'b1;
            halt <= 1'b0;
        end
        6'b000010 : begin   //SUB
            inst_type <= 2'b01;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b0001;
            reg_read_a <= 1; reg_read_b <= 1; reg_write <= 1;
            wb_sel <= 2'b00;
            read_mem <= 1'b0;
            write_mem <= 1'b0;
            jmp_mode <= 2'b00;
            push <= 1'b0;
            pop <= 1'b0;
            update_flags <= 1'b1;
            halt <= 1'b0;
        end
        6'b000011 : begin   //OR
            inst_type <= 2'b01;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b0010;
            reg_read_a <= 1; reg_read_b <= 1; reg_write <= 1;
            src_sel <= 2'b00;
            wb_sel <= 2'b00;
            read_mem <= 1'b0;
            write_mem <= 1'b0;
            jmp_mode <= 2'b00;
            push <= 1'b0;
            pop <= 1'b0;
            update_flags <= 1'b1;
            halt <= 1'b0;
        end
        6'b000100 : begin   //AND
            inst_type <= 2'b01;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b0011;
            reg_read_a <= 1; reg_read_b <= 1; reg_write <= 1; 
            src_sel <= 2'b00;
            wb_sel <= 2'b00;
            read_mem <= 1'b0;
            write_mem <= 1'b0;
            jmp_mode <= 2'b00;
            push <= 1'b0;
            pop <= 1'b0;
            update_flags <= 1'b1;
            halt <= 1'b0;
        end
        6'b000101 : begin   //XOR
            inst_type <= 2'b01;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b0100;
            reg_read_a <= 1; reg_read_b <= 1; reg_write <= 1; 
            src_sel <= 2'b00;
            wb_sel <= 2'b00;
            read_mem <= 1'b0;
            write_mem <= 1'b0;
            jmp_mode <= 2'b00;
            push <= 1'b0;
            pop <= 1'b0;
            update_flags <= 1'b1;
            halt <= 1'b0;
        end
        6'b000110 : begin   //NOR
            inst_type <= 2'b01;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b0101;
            reg_read_a <= 1; reg_read_b <= 1; reg_write <= 1; 
            src_sel <= 2'b00;
            wb_sel <= 2'b00;
            read_mem <= 1'b0;
            write_mem <= 1'b0;
            jmp_mode <= 2'b00;
            push <= 1'b0;
            pop <= 1'b0;
            update_flags <= 1'b1;
            halt <= 1'b0;
        end
        6'b000111 : begin   //NAND
            inst_type <= 2'b01;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b0110;
            reg_read_a <= 1; reg_read_b <= 1; reg_write <= 1; 
            src_sel <= 2'b00;
            wb_sel <= 2'b00;
            read_mem <= 1'b0;
            write_mem <= 1'b0;
            jmp_mode <= 2'b00;
            push <= 1'b0;
            pop <= 1'b0;
            update_flags <= 1'b1;
            halt <= 1'b0;
        end
        6'b001000 : begin   //XNOR
            inst_type <= 2'b01;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b0111;
            reg_read_a <= 1; reg_read_b <= 1; reg_write <= 1; 
            src_sel <= 2'b00;
            wb_sel <= 2'b00;
            read_mem <= 1'b0;
            write_mem <= 1'b0;
            jmp_mode <= 2'b00;
            push <= 1'b0;
            pop <= 1'b0;
            update_flags <= 1'b1;
            halt <= 1'b0;
        end
        6'b001001 : begin   //INV
            inst_type <= 2'b01;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b1100;
            reg_read_a <= 0; reg_read_b <= 1; reg_write <= 1; 
            src_sel <= 2'b00;
            wb_sel <= 2'b00;
            read_mem <= 1'b0;
            write_mem <= 1'b0;
            jmp_mode <= 2'b00;
            push <= 1'b0;
            pop <= 1'b0;
            update_flags <= 1'b1;
            halt <= 1'b0;
        end
        6'b001010 : begin   //BSHL
            inst_type <= 2'b01;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b1000;
            reg_read_a <= 1; reg_read_b <= 1; reg_write <= 1; 
            src_sel <= 2'b00;
            wb_sel <= 2'b00;
            read_mem <= 1'b0;
            write_mem <= 1'b0;
            jmp_mode <= 2'b00;
            push <= 1'b0;
            pop <= 1'b0;
            update_flags <= 1'b1;
            halt <= 1'b0;
        end
        6'b001011 : begin   //BSHR
            inst_type <= 2'b01;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b1001;
            reg_read_a <= 1; reg_read_b <= 1; reg_write <= 1; 
            src_sel <= 2'b00;
            wb_sel <= 2'b00;
            read_mem <= 1'b0;
            write_mem <= 1'b0;
            jmp_mode <= 2'b00;
            push <= 1'b0;
            pop <= 1'b0;
            update_flags <= 1'b1;
            halt <= 1'b0;
        end
        6'b001100 : begin   //SBSHL
            inst_type <= 2'b01;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b1010;
            reg_read_a <= 1; reg_read_b <= 1; reg_write <= 1; 
            src_sel <= 2'b00;
            wb_sel <= 2'b00;
            read_mem <= 1'b0;
            write_mem <= 1'b0;
            jmp_mode <= 2'b00;
            push <= 1'b0;
            pop <= 1'b0;
            update_flags <= 1'b1;
            halt <= 1'b0;
        end
        6'b001101 : begin   //SBSHR
            inst_type <= 2'b01;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b1011;
            reg_read_a <= 1; reg_read_b <= 1; reg_write <= 1; 
            src_sel <= 2'b00;
            wb_sel <= 2'b00;
            read_mem <= 1'b0;
            write_mem <= 1'b0;
            jmp_mode <= 2'b00;
            push <= 1'b0;
            pop <= 1'b0;
            update_flags <= 1'b1;
            halt <= 1'b0;
        end
        6'b001110 : begin   //LDIM
            inst_type <= 2'b10;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b0010;
            reg_read_a <= 0; reg_read_b <= 0; reg_write <= 1; 
            src_sel <= 2'b01;
            wb_sel <= 2'b00;
            read_mem <= 1'b0;
            write_mem <= 1'b0;
            jmp_mode <= 2'b00;
            push <= 1'b0;
            pop <= 1'b0;
            update_flags <= 1'b0;
            halt <= 1'b0;
        end
        6'b001111 : begin   //ADDI
            inst_type <= 2'b10;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b0000;
            reg_read_a <= 1; reg_read_b <= 0; reg_write <= 1; 
            src_sel <= 2'b01;
            wb_sel <= 2'b00;
            read_mem <= 1'b0;
            write_mem <= 1'b0;
            jmp_mode <= 2'b00;
            push <= 1'b0;
            pop <= 1'b0;
            update_flags <= 1'b1;
            halt <= 1'b0;
        end
        6'b010000 : begin   //SUBI
            inst_type <= 2'b10;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b0001;
            reg_read_a <= 1; reg_read_b <= 0; reg_write <= 1; 
            src_sel <= 2'b01;
            wb_sel <= 2'b00;
            read_mem <= 1'b0;
            write_mem <= 1'b0;
            jmp_mode <= 2'b00;
            push <= 1'b0;
            pop <= 1'b0;
            update_flags <= 1'b1;
            halt <= 1'b0;
        end
        6'b010001 : begin   //ORI
            inst_type <= 2'b10;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b0010;
            reg_read_a <= 1; reg_read_b <= 0; reg_write <= 1; 
            src_sel <= 2'b01;
            wb_sel <= 2'b00;
            read_mem <= 1'b0;
            write_mem <= 1'b0;
            jmp_mode <= 2'b00;
            push <= 1'b0;
            pop <= 1'b0;
            update_flags <= 1'b1;
            halt <= 1'b0;
        end
        6'b010010 : begin   //ANDI
            inst_type <= 2'b10;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b0011;
            reg_read_a <= 1; reg_read_b <= 0; reg_write <= 1; 
            src_sel <= 2'b01;
            wb_sel <= 2'b00;
            read_mem <= 1'b0;
            write_mem <= 1'b0;
            jmp_mode <= 2'b00;
            push <= 1'b0;
            pop <= 1'b0;
            update_flags <= 1'b1;
            halt <= 1'b0;
        end
        6'b010011 : begin   //XORI
            inst_type <= 2'b10;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b0100;
            reg_read_a <= 1; reg_read_b <= 0; reg_write <= 1; 
            src_sel <= 2'b01;
            wb_sel <= 2'b00;
            read_mem <= 1'b0;
            write_mem <= 1'b0;
            jmp_mode <= 2'b00;
            push <= 1'b0;
            pop <= 1'b0;
            update_flags <= 1'b1;
            halt <= 1'b0;
        end
        6'b010100 : begin   //NORI
            inst_type <= 2'b10;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b0101;
            reg_read_a <= 1; reg_read_b <= 0; reg_write <= 1; 
            src_sel <= 2'b01;
            wb_sel <= 2'b00;
            read_mem <= 1'b0;
            write_mem <= 1'b0;
            jmp_mode <= 2'b00;
            push <= 1'b0;
            pop <= 1'b0;
            update_flags <= 1'b1;
            halt <= 1'b0;
        end
        6'b010101 : begin   //NANDI
            inst_type <= 2'b10;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b0110;
            reg_read_a <= 1; reg_read_b <= 0; reg_write <= 1; 
            src_sel <= 2'b01;
            wb_sel <= 2'b00;
            read_mem <= 1'b0;
            write_mem <= 1'b0;
            jmp_mode <= 2'b00;
            push <= 1'b0;
            pop <= 1'b0;
            update_flags <= 1'b1;
            halt <= 1'b0;
        end
        6'b010110 : begin   //XNORI
            inst_type <= 2'b10;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b0111;
            reg_read_a <= 1; reg_read_b <= 0; reg_write <= 1; 
            src_sel <= 2'b01;
            wb_sel <= 2'b00;
            read_mem <= 1'b0;
            write_mem <= 1'b0;
            jmp_mode <= 2'b00;
            push <= 1'b0;
            pop <= 1'b0;
            update_flags <= 1'b1;
            halt <= 1'b0;
        end
        6'b010111 : begin   //BSHLI
            inst_type <= 2'b10;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b1000;
            reg_read_a <= 1; reg_read_b <= 0; reg_write <= 1; 
            src_sel <= 2'b01;
            wb_sel <= 2'b00;
            read_mem <= 1'b0;
            write_mem <= 1'b0;
            jmp_mode <= 2'b00;
            push <= 1'b0;
            pop <= 1'b0;
            update_flags <= 1'b1;
            halt <= 1'b0;
        end
        6'b011000 : begin   //BSHRI
            inst_type <= 2'b10;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b1001;
            reg_read_a <= 1; reg_read_b <= 0; reg_write <= 1; 
            src_sel <= 2'b01;
            wb_sel <= 2'b00;
            read_mem <= 1'b0;
            write_mem <= 1'b0;
            jmp_mode <= 2'b00;
            push <= 1'b0;
            pop <= 1'b0;
            update_flags <= 1'b1;
            halt <= 1'b0;
        end
        6'b011001 : begin   //SBSHLI
            inst_type <= 2'b10;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b1010;
            reg_read_a <= 1; reg_read_b <= 0; reg_write <= 1; 
            src_sel <= 2'b01;
            wb_sel <= 2'b00;
            read_mem <= 1'b0;
            write_mem <= 1'b0;
            jmp_mode <= 2'b00;
            push <= 1'b0;
            pop <= 1'b0;
            update_flags <= 1'b1;
            halt <= 1'b0;
        end
        6'b011010 : begin   //SBSHRI
            inst_type <= 2'b10;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b1011;
            reg_read_a <= 1; reg_read_b <= 0; reg_write <= 1; 
            src_sel <= 2'b01;
            wb_sel <= 2'b00;
            read_mem <= 1'b0;
            write_mem <= 1'b0;
            jmp_mode <= 2'b00;
            push <= 1'b0;
            pop <= 1'b0;
            update_flags <= 1'b1;
            halt <= 1'b0;
        end
        6'b011011 : begin   //ISUBI
            inst_type <= 2'b10;
            alu_c_in <= 0; alu_enable <= 1;
            alu_sel <= 4'b1100;
            reg_read_a <= 1; reg_read_b <= 0; reg_write <= 1; 
            src_sel <= 2'b01;
            wb_sel <= 2'b00;
            read_mem <= 1'b0;
            write_mem <= 1'b0;
            jmp_mode <= 2'b00;
            push <= 1'b0;
            pop <= 1'b0;
            update_flags <= 1'b1;
            halt <= 1'b0;
        end
        6'b011100 : begin   //MLD
            inst_type <= 2'b10;
            alu_c_in <= 0; alu_enable <= 0;
            alu_sel <= 4'b0000;
            reg_read_a <= 0; reg_read_b <= 0; reg_write <= 1; 
            src_sel <= 2'b01;
            wb_sel <= 2'b01;
            read_mem <= 1'b1;
            write_mem <= 1'b0;
            jmp_mode <= 2'b00;
            push <= 1'b0;
            pop <= 1'b0;
            update_flags <= 1'b0;
            halt <= 1'b0;
        end
        6'b011101 : begin   //MST
            inst_type <= 2'b10;
            alu_c_in <= 0; alu_enable <= 0;
            alu_sel <= 4'b0000;
            reg_read_a <= 1; reg_read_b <= 0; reg_write <= 0; 
            src_sel <= 2'b01;
            wb_sel <= 2'b00;
            read_mem <= 1'b0;
            write_mem <= 1'b1;
            jmp_mode <= 2'b00;
            push <= 1'b0;
            pop <= 1'b0;
            update_flags <= 1'b0;
            halt <= 1'b0;
        end
        6'b011110 : begin   //PML
            inst_type <= 2'b01;
            alu_c_in <= 0; alu_enable <= 0;
            alu_sel <= 4'b0000;
            reg_read_a <= 0; reg_read_b <= 1; reg_write <= 1; 
            src_sel <= 2'b00;
            wb_sel <= 2'b01;
            read_mem <= 1'b1;
            write_mem <= 1'b0;
            jmp_mode <= 2'b00;
            push <= 1'b0;
            pop <= 1'b0;
            update_flags <= 1'b0;
            halt <= 1'b0;
        end
        6'b011111 : begin   //PMS
            inst_type <= 2'b01;
            alu_c_in <= 0; alu_enable <= 0;
            alu_sel <= 4'b0000;
            reg_read_a <= 0; reg_read_b <= 1; reg_write <= 0; 
            src_sel <= 2'b00;
            wb_sel <= 2'b00;
            read_mem <= 1'b0;
            write_mem <= 1'b1;
            jmp_mode <= 2'b00;
            push <= 1'b0;
            pop <= 1'b0;
            update_flags <= 1'b0;
            halt <= 1'b0;
        end
        6'b100000 : begin     //BRC
            inst_type <= 2'b11;
            alu_c_in <= 0; alu_enable <= 0;
            alu_sel <= 4'b0000;
            reg_read_a <= 0; reg_read_b <= 0; reg_write <= 0; 
            src_sel <= 2'b01;
            wb_sel <= 2'b00;
            read_mem <= 1'b0;
            write_mem <= 1'b0;
            jmp_mode <= 2'b10;
            push <= 1'b0;
            pop <= 1'b0;
            update_flags <= 1'b0;
            halt <= 1'b0;
        end
        6'b100001 : begin     //JMP
            inst_type <= 2'b11;
            alu_c_in <= 0; alu_enable <= 0;
            alu_sel <= 4'b0000;
            reg_read_a <= 0; reg_read_b <= 0; reg_write <= 0; 
            src_sel <= 2'b01;
            wb_sel <= 2'b00;
            read_mem <= 1'b0;
            write_mem <= 1'b0;
            jmp_mode <= 2'b01;
            push <= 1'b0;
            pop <= 1'b0;
            update_flags <= 1'b0;
            halt <= 1'b0;
        end
        6'b100010 : begin     //PBR
            inst_type <= 2'b11;
            alu_c_in <= 0; alu_enable <= 0;
            alu_sel <= 4'b0000;
            reg_read_a <= 0; reg_read_b <= 1; reg_write <= 0; 
            src_sel <= 2'b00;
            wb_sel <= 2'b00;
            read_mem <= 1'b0;
            write_mem <= 1'b0;
            jmp_mode <= 2'b10;
            push <= 1'b0;
            pop <= 1'b0;
            update_flags <= 1'b0;
            halt <= 1'b0;
        end
        6'b100011 : begin     //PJM
            inst_type <= 2'b11;
            alu_c_in <= 0; alu_enable <= 0;
            alu_sel <= 4'b0000;
            reg_read_a <= 0; reg_read_b <= 1; reg_write <= 0; 
            src_sel <= 2'b00;
            wb_sel <= 2'b00;
            read_mem <= 1'b0;
            write_mem <= 1'b0;
            jmp_mode <= 2'b01;
            push <= 1'b0;
            pop <= 1'b0;
            update_flags <= 1'b0;
            halt <= 1'b0;
        end
        6'b100100 : begin   //CAL
            inst_type <= 2'b11;
            alu_c_in <= 0; alu_enable <= 0;
            alu_sel <= 4'b0000;
            reg_read_a <= 0; reg_read_b <= 0; reg_write <= 0; 
            src_sel <= 2'b01;
            wb_sel <= 2'b00;
            read_mem <= 1'b0;
            write_mem <= 1'b0;
            jmp_mode <= 2'b01;
            push <= 1'b1;
            pop <= 1'b0;
            update_flags <= 1'b0;
            halt <= 1'b0;
        end
        6'b100101 : begin   //RET
            inst_type <= 2'b11;
            alu_c_in <= 0; alu_enable <= 0;
            alu_sel <= 4'b0000;
            reg_read_a <= 0; reg_read_b <= 0; reg_write <= 0; 
            src_sel <= 2'b01;
            wb_sel <= 2'b00;
            read_mem <= 1'b0;
            write_mem <= 1'b0;
            jmp_mode <= 2'b11;
            push <= 1'b0;
            pop <= 1'b1;
            update_flags <= 1'b0;
            halt <= 1'b0;
        end
        6'b100110 : begin   //BIN
            inst_type <= 2'b00;
            alu_c_in <= 0; alu_enable <= 0;
            alu_sel <= 4'b0000;
            reg_read_a <= 0; reg_read_b <= 0; reg_write <= 0; 
            src_sel <= 2'b00;
            wb_sel <= 2'b00;
            read_mem <= 1'b0;
            write_mem <= 1'b0;
            jmp_mode <= 2'b00;
            push <= 1'b0;
            pop <= 1'b0;
            update_flags <= 1'b0;
            halt <= 1'b0;

            i_block <= 1'b1;
        end
        6'b100111 : begin   //EIN
            inst_type <= 2'b00;
            alu_c_in <= 0; alu_enable <= 0;
            alu_sel <= 4'b0000;
            reg_read_a <= 0; reg_read_b <= 0; reg_write <= 0; 
            src_sel <= 2'b00;
            wb_sel <= 2'b00;
            read_mem <= 1'b0;
            write_mem <= 1'b0;
            jmp_mode <= 2'b00;
            push <= 1'b0;
            pop <= 1'b0;
            update_flags <= 1'b0;
            halt <= 1'b0;

            i_block <= 1'b0;
        end
        6'b111111 : begin   //HLT
            inst_type <= 2'b00;
            alu_c_in <= 0; alu_enable <= 0;
            alu_sel <= 4'b0000;
            reg_read_a <= 0; reg_read_b <= 0; reg_write <= 0; 
            src_sel <= 2'b00;
            wb_sel <= 2'b00;
            read_mem <= 1'b0;
            write_mem <= 1'b0;
            jmp_mode <= 2'b00;
            push <= 1'b0;
            pop <= 1'b0;
            update_flags <= 1'b0;
            halt <= 1'b1;
        end
        default : begin     //NOP
            inst_type <= 2'b00;
            alu_c_in <= 0; alu_enable <= 0;
            alu_sel <= 4'b0000;
            reg_read_a <= 0; reg_read_b <= 0; reg_write <= 0; 
            src_sel <= 2'b00;
            wb_sel <= 2'b00;
            read_mem <= 1'b0;
            write_mem <= 1'b0;
            jmp_mode <= 2'b00;
            push <= 1'b0;
            pop <= 1'b0;
            update_flags <= 1'b0;
            halt <= 1'b0;
        end
    endcase
  end
endmodule
