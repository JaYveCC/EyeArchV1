module cond_val_reg (
    input logic clk, update_flags, c_out,
    input logic [15:0] wb_bus,
    output logic cond_c_out,
    output logic [15:0] cond_val_out
);
    always @(negedge clk) begin
        if (update_flags) begin
            cond_val_out <= wb_bus;
            cond_c_out <= c_out;
        end
    end
endmodule
