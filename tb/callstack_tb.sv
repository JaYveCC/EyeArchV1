module callstack_tb;
    reg push, pop, reset;
    reg [15:0] d_in;
    /* verilator lint_off UNUSEDSIGNAL */
    wire full;
    wire empty;
    wire [15:0] d_out;
    /* verilator lint_on UNUSEDSIGNAL */

    callstack dut (
        .push (push),
        .pop (pop),
        .reset (reset),
        .full (full),
        .empty (empty),
        .d_in (d_in),
        .d_out (d_out)
    );

    initial begin
        $dumpfile("callstack_tb.vcd");
        $dumpvars(0, callstack_tb);

        reset = 1'b1;
        #40
        reset = 1'b0;

        while (!full) begin
            #40
            /* verilator lint_off WIDTHTRUNC */
            d_in = $random;
            /* verilator lint_on WIDTHTRUNC */
            #40
            push = 1'b1;
            #40
            push = 1'b0;
        end
        
        while (!empty) begin
            #40 pop = ~pop;
        end

        $finish;
    end
endmodule
