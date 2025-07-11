module callstack (
    input logic push, pop, reset,
    input logic [23:0] d_in,
    output wire full, empty,
    output logic [23:0] d_out
);

    reg [23:0] stack [0:31];
    reg [4:0] pointer;

    assign full = (pointer == 31) ? 1'b1 : 1'b0;
    assign empty = (pointer == 0) ? 1'b1 : 1'b0;

    always @(posedge push or posedge pop or posedge reset) begin
        if (reset) begin
            pointer <= 5'b0;

            for (int i = 0; i < 32; i++) begin
                stack[i] <= 24'b0;
            end
        end

        if (push) begin
            stack[pointer] <= d_in;
            pointer <= pointer + 1;
        end

        if (pop) begin
            pointer <= pointer - 1;
        end
    end

    assign d_out = stack[pointer];
endmodule
