module regfile (
    input logic clk, read_a, read_b, write, reset,
    input logic [4:0] w_addr, a_addr, b_addr,
    input logic [15:0] d_in,
    output logic [15:0] a_out, b_out
);

    logic [15:0] mem [1:31];
    always_comb begin
        if (read_a) begin
            a_out = mem[a_addr];
        end else begin
            a_out = 16'b0;
        end

        if (read_b) begin
            b_out = mem[b_addr];
        end else begin
            b_out = 16'b0;
        end        
    end

    always @(negedge clk) begin
        if (reset) begin
            for (int i = 0; i < 32; i++) begin
                mem[i] <= 16'b0;
            end
        end

        if (write) begin
            mem[w_addr] <= d_in;
        end
    end
endmodule
