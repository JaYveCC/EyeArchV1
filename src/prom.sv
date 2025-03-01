`timescale 1ns / 1ps
module prom (
    input logic clk,
    input logic [15:0] addr,
    output logic [31:0] instruction
);
    reg [31:0] next_instruction;
    reg [31:0] rom [0:65535];

    initial begin
        $readmemh("assembly.mem", rom);
    end

    always @(posedge clk) begin
        instruction <= next_instruction;
    end

    always @(addr) begin
        next_instruction <= rom[addr];
    end
endmodule
