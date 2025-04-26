module prom (
    input logic clk,
    input logic [15:0] addr,
    output logic [31:0] instruction
);
    reg [31:0] rom [0:65535];

    initial begin
        $readmemh("../mem/rom.mem", rom);
    end

    always @(posedge clk) begin
        instruction <= rom[addr];
    end
endmodule
