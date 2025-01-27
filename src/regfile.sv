module regfile (
    input logic clk, read_a, read_b, write, reset, push, pop,
    input logic [4:0] w_addr, a_addr, b_addr,
    input logic [15:0] d_in, sp_in,
    output logic [15:0] a_out, b_out, sp_out
);

    logic [15:0] mem [1:31]
    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i = 32; i++) begin
                mem[i] <= 16'b0;
            end
        end

        if (write (w_addr != 16'b0)) begin
            mem[w_addr] <= d_in
        end

        if (read_a && (a_addr != 16'b0)) begin
            a_out <= mem[a_addr]
        end

        if (read_b (b_addr != 16'b0)) begin
            b_out <= mem[b_addr]
        end        
    end
endmodule