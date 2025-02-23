module prom (
    input logic [15:0] addr,
    input logic read,
    output logic [31:0] instruction
);
    reg [31:0] rom [0:65535];
    initial begin
        $readmemh("assembly.mem", rom);
    end

    always @(addr) begin
        if (read) begin
            instruction <= rom[addr];
        end
    end
endmodule
