module pc (
    input logic clk,
    output logic [15:0] addr
);
    always @(negedge clk) begin
        addr <= addr + 16'b1;
    end
endmodule
