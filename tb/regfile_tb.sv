module regfile_tb;
    reg clk, read_a, read_b, write, reset;
    reg [4:0] w_addr, a_addr, b_addr;
    reg [15:0] d_in;
    /* verilator lint_off UNUSEDSIGNAL */
    wire [15:0] a_out, b_out;
    /* verilator lint_on UNUSEDSIGNAL */
    
    regfile dut (
        .clk (clk),
        .read_a (read_a),
        .read_b (read_b),
        .write (write),
        .reset (reset),
        .w_addr (w_addr),
        .a_addr (a_addr),
        .b_addr (b_addr),
        .d_in (d_in),
        .a_out (a_out),
        .b_out (b_out)
    );

    initial begin
        clk = 1'b0;
        forever #10 clk = ~clk;
    end

    initial begin
        $dumpfile("regfile_tb.vcd");
        $dumpvars(0, regfile_tb);

        w_addr = 5'b10101;
        write = 1'b1;
        d_in = 16'b1;
        #40
        a_addr = 5'b10101;
        read_a = 1'b1;
        w_addr = 5'b01010;
        write = 1'b1;
        d_in = 16'b10;
        #40
        a_addr = 5'b10101;
        read_a = 1'b1;
        b_addr = 5'b01010;
        read_b = 1'b1;
        w_addr = 5'b00000;
        write = 1'b1;
        d_in = 16'b11;
        #40
        a_addr = 5'b00000;
        read_b = 1'b1;
        #40
        reset = 1'b1;
        #40
        a_addr = 5'b10101;
        read_a = 1'b1;
        b_addr = 5'b01010;
        read_b = 1'b1;
        #40
        $finish;
    end
endmodule
