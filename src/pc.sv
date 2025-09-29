module pc (
    /* verilator lint_off UNUSEDSIGNAL */
    input logic clk, interrupt, pop, update_flags,
    input logic [1:0] jmp_mode,
    input logic [4:0] cond,
    input logic [7:0] flags, cs_flags,
    input logic [15:0] jmp_addr, cs_addr, interrupt_addr,
    output wire [7:0] curent_flags,
    output logic [15:0] addr
    /* verilator lint_on UNUSEDSIGNAL */
);
    logic [7:0] brc_flags;
    logic [7:0] tmp_brc_flags;

    assign curent_flags = brc_flags;

    /* verilator lint_off BLKSEQ */
    always @(negedge clk) begin
        tmp_brc_flags = brc_flags;
        if (update_flags) begin
            tmp_brc_flags = flags;
        end else if (pop) begin
            tmp_brc_flags = cs_flags;
        end

        if (interrupt) begin
            addr <= interrupt_addr;
        end else begin
            case (jmp_mode)
            2'b01: addr <= jmp_addr; //jmp
            2'b10: begin //brc
                if (tmp_brc_flags[cond[2:0]]) begin
                    addr <= jmp_addr;
                end
            end
            2'b11: addr <= cs_addr; //ret
            default: addr <= addr + 16'b1; //normal
        endcase
        end

        brc_flags <= tmp_brc_flags;
    end
    /* verilator lint_on BLKSEQ */
endmodule
