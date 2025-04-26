module bu (
    input logic jmp, brc, c_out,
    input logic [4:0] cond,
    input logic [15:0] wb_val,
    output logic jmp_true
);
    always_comb begin
        jmp_true = 1'b0;
        if (jmp) begin
            if (brc) begin
                case (cond)
                    5'b00000: begin     //zero
                        if (wb_val == 16'b0) begin
                            jmp_true = 1'b1;
                        end
                    end
                    5'b00001: begin     //nzero
                        if (wb_val != 16'b0) begin
                            jmp_true = 1'b1;
                        end
                    end
                    5'b00010: begin     //cout
                        if (c_out) begin
                            jmp_true = 1'b1;
                        end
                    end
                    5'b00011: begin     //ncout
                        if (!c_out) begin
                            jmp_true = 1'b1;
                        end
                    end
                    5'b00100: begin     //odd
                        if (wb_val[0]) begin
                            jmp_true = 1'b1;
                        end
                    end
                    5'b00101: begin     //even
                        if (!wb_val[0]) begin
                            jmp_true = 1'b1;
                        end
                    end
                    5'b00110: begin     //msb
                        if (wb_val[15]) begin
                            jmp_true = 1'b1;
                        end
                    end
                    5'b00111: begin     //nmsb
                        if (!wb_val[15]) begin
                            jmp_true = 1'b1;
                        end
                    end
                    default: jmp_true = 1'b0;
                endcase
            end else begin
                jmp_true = 1'b1;
            end
        end
    end
endmodule
