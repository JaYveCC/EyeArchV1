module pc (
    input logic clk, jmp,
    input logic [15:0] jmp_addr,
    output logic [15:0] addr
);
    always @(negedge clk) begin
        if (jmp) begin
            addr <= jmp_addr;
        end else begin
            addr <= addr + 16'b1;
        end
    end
endmodule
