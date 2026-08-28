// Designed by Sanjaykumar R

module mux_2_to_1(
    input  a,
    input  b,
    input  s,
    output y
);

    assign y = s ? b : a;

endmodule

module mux_4_to_1_using_2_to_1(
    input  [3:0] d,
    input  [1:0] s,
    output y
);

    wire y0, y1;

    mux_2_to_1 m0(
        .a(d[0]),
        .b(d[1]),
        .s(s[0]),
        .y(y0)
    );

    mux_2_to_1 m1(
        .a(d[2]),
        .b(d[3]),
        .s(s[0]),
        .y(y1)
    );

    mux_2_to_1 m2(
        .a(y0),
        .b(y1),
        .s(s[1]),
        .y(y)
    );

endmodule

module tb_mux_4_to_1_using_2_to_1;

reg  [3:0] d;
reg  [1:0] s;
wire y;

mux_4_to_1_using_2_to_1 dut(
    .d(d),
    .s(s),
    .y(y)
);

initial
begin
    $dumpfile("mux_4_to_1_using_2_to_1.vcd");
    $dumpvars(0, tb_mux_4_to_1_using_2_to_1);

    $monitor("D=%b S=%b Y=%b", d, s, y);

    d=4'b1010; s=2'b00; #10;
    d=4'b1010; s=2'b01; #10;
    d=4'b1010; s=2'b10; #10;
    d=4'b1010; s=2'b11; #10;

    $finish;
end

endmodule
