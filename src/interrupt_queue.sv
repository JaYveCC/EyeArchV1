`include "./src/parameters.svh"

module interrupt_queue (
    input logic clk, reset, i_block,
    input logic interrupt_confirm [0:`INTERRUPT_COUNT-1],
    input logic [15:0] interrupt_id [0:`INTERRUPT_COUNT-1],
    output logic execute_interrupt,
    output logic [15:0] executing_id,
    output logic acknowledge [0:`INTERRUPT_COUNT-1]
);
    reg [15:0] lifo [0:31];
    reg [4:0] r_pointer;
    reg [4:0] w_pointer;

    logic [4:0] w_pointer_tmp;

    logic full;
    wire empty;

    assign empty = (w_pointer == r_pointer) ? 1'b1 : 1'b0;

    assign execute_interrupt = (!empty && !i_block) ? 1'b1 : 1'b0;

    always @(posedge clk) begin
    if (!empty && !i_block) begin
            executing_id <= lifo[r_pointer];
            r_pointer <= r_pointer + 5'b1;
        end
    end

    always @(negedge clk) begin
        if (reset) begin
            for (int i = 0; i < 16; i++) begin
                lifo[i] <= 16'b0;
            end
        end
        
        /* verilator lint_off BLKSEQ */
        w_pointer_tmp = w_pointer;
        for (int i = 0; i < `INTERRUPT_COUNT; i++) begin
            full = (w_pointer_tmp + 5'b1 == r_pointer) ? 1'b1 : 1'b0;
            if (interrupt_confirm[i] && !full) begin
                lifo[w_pointer_tmp] <= interrupt_id[i];
                acknowledge[i] <= 1'b1;
                w_pointer_tmp = w_pointer_tmp + 5'b1;
            end else begin
                acknowledge[i] <= 1'b0;
            end
        end
        w_pointer <= w_pointer_tmp;
        /* verilator lint_on BLKSEQ */
    end
endmodule
