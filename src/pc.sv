module pc (
    input logic clk, reset,
    output logic [15:0] addr
);
    reg [15:0] next_addr;
    always @(posedge clk) begin
        addr <= next_addr;
        addr <= addr + 16'b1;
        if (reset) begin
            next_addr <= 0;
        end
    end
endmodule
