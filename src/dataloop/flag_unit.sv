module flag_unit (
    input logic c_out,
    input logic [15:0] wb_val,
    output wire [7:0] flags
);
    assign flags[0] = (wb_val == 16'b0) ? 1'b1 : 1'b0; //zero
    assign flags[1] = (wb_val != 16'b0) ? 1'b1 : 1'b0; //nzero
    assign flags[2] = (c_out) ? 1'b1 : 1'b0; //cout
    assign flags[3] = (!c_out) ? 1'b1 : 1'b0; //ncout
    assign flags[4] = (wb_val[0]) ? 1'b1 : 1'b0; //odd
    assign flags[5] = (!wb_val[0]) ? 1'b1 : 1'b0; //even
    assign flags[6] = (wb_val[15]) ? 1'b1 : 1'b0; //msb
    assign flags[7] = (!wb_val[15]) ? 1'b1 : 1'b0; //nmsb
endmodule
