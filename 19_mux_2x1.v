// Designed by Sanjaykumar R

module mux_2_to_1(
    input  a,
    input  b,
    input  s,
    output y
);

    assign y = s ? b : a;

endmodule

module tb_mux_2_to_1;

    reg a;
    reg b;
    reg s;

    wire y;

    mux_2_to_1 dut(
        .a(a),
        .b(b),
        .s(s),
        .y(y)
    );

    initial
    begin

        $dumpfile("mux_2_to_1.vcd");
        $dumpvars(0, tb_mux_2_to_1);

        $monitor("A=%b B=%b S=%b Y=%b",
                 a, b, s, y);

        a = 0; b = 0; s = 0; #10;
        a = 0; b = 1; s = 0; #10;
        a = 0; b = 1; s = 1; #10;
        a = 1; b = 0; s = 0; #10;
        a = 1; b = 0; s = 1; #10;
        a = 1; b = 1; s = 1; #10;

        $finish;

    end

endmodule
