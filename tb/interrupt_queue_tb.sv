`include "./src/parameters.svh"

module interrupt_queue_tb;
    /* verilator lint_off UNUSEDSIGNAL */
    reg clk;
    reg reset;
    reg i_block;
    reg interrupt_confirm [0:`INTERRUPT_COUNT-1];
    reg [15:0] interrupt_id [0:`INTERRUPT_COUNT-1];
    wire execute_interrupt;
    wire [15:0] executing_id;
    wire acknowledge [0:`INTERRUPT_COUNT-1];
    /* verilator lint_on UNUSEDSIGNAL */

    interrupt_queue dut (
        .clk (clk),
        .reset (reset),
        .i_block (i_block),
        .interrupt_confirm (interrupt_confirm),
        .interrupt_id (interrupt_id),
        .execute_interrupt (execute_interrupt),
        .executing_id (executing_id),
        .acknowledge (acknowledge)
    );

    initial begin
        forever #40 clk = ~clk;
    end

    initial begin
        forever begin
            #120 i_block = 1'b1;
            #60 i_block = 1'b0;
        end
    end

    initial begin
        $dumpfile("interrupt_queue_tb.vcd");
        $dumpvars(0, interrupt_queue_tb);

        reset = 1'b1;
        #40
        reset = 1'b0;

        /* verilator lint_off WIDTHTRUNC */
        for (int i  = 0; i < 64; i++) begin
            #80
            for (int j = 0; j < `INTERRUPT_COUNT; j++) begin
                interrupt_id[j] = j + (i << 4);
                interrupt_confirm[j] = $random;
            end
        end
        /* verilator lint_on WIDTHTRUNC */
        $finish;
    end
endmodule
