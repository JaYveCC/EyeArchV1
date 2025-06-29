`include "../src/parameters.svh"

module interrupt_queue (
    input logic clk, reset, i_block,
    input logic interrupt_confirm [0:`INTERRUPT_COUNT-1],
    input logic [15:0] interrupt_id [0:`INTERRUPT_COUNT-1],
    output logic execute_interrupt,
    output logic [15:0] executing_id,
    output logic acknowledge [0:`INTERRUPT_COUNT-1];
);
    reg [15:0] lifo [0:15];
    reg [3:0] r_pointer;
    reg [3:0] w_pointer;

    wire full;
    wire empty;

    assign full = (w_pointer == r_pointer + 4'b1) ? 1'b1 : 1'b0;
    assign empty = (w_pointer == r_pointer) ? 1'b1 : 1'b0;

    always @(posedge clk) begin
        if (!empty && !i_block) begin
            executing_id <= lifo[r_pointer];
            execute_interrupt <= 1'b1;
            r_pointer <= r_pointer + 4'b1;
        end else begin
            execute_interrupt <= 1'b0;
        end

        if (reset) begin
            for (int i = 0; i < 16; i++) begin
                lifo[i] <= 16'b0;
            end
        end
    end

    always @(interrupt_confirm) begin
        if (!full) begin
            for (int i = 0; i < `INTERRUPT_COUNT; i++) begin
                if (interrupt_confirm[i]) begin
                    lifo[w_pointer] <= interrupt_id[i];
                    acknowledge <= 1'b1;
                    w_pointer <= w_pointer + 4'b1;
                end else begin
                    acknowledge[i] <= 1'b0;
                end
            end
        end
    end
endmodule
