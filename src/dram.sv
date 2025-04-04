module dram (
    input logic clk, read, write,
    input logic [15:0] addr, d_in,
    output logic [15:0] d_out
);
    reg [15:0] ram [0:65535];

    initial begin
        $readmemh("mem/ram.mem", ram);
    end

    always @(posedge clk) begin
        if (write) begin
            ram[addr] <= d_in;
        end
    end

    always @(*) begin
        d_out = 16'b0;
        if (read) begin
            d_out = ram[addr];
        end
    end
endmodule
