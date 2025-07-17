module pc (
    /* verilator lint_off UNUSEDSIGNAL */
    input logic clk, jmp, brc, update_flags,
    input logic [4:0] cond,
    input logic [7:0] flags,
    input logic [15:0] jmp_addr,
    output logic [15:0] addr
    /* verilator lint_on UNUSEDSIGNAL */
);
    logic [7:0] brc_flags;
    logic [7:0] tmp_brc_flags;

    /* verilator lint_off BLKSEQ */
    always @(negedge clk) begin
        tmp_brc_flags = brc_flags;
        if (update_flags) begin
            tmp_brc_flags = flags;
        end

        if ((jmp && !brc) | (jmp && brc && tmp_brc_flags[cond[2:0]])) begin
            addr <= jmp_addr;
        end else begin
            addr <= addr + 16'b1;
        end

        brc_flags <= tmp_brc_flags;
    end
    /* verilator lint_on BLKSEQ */
endmodule
