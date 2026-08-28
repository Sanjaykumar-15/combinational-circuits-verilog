// Designed by Sanjaykumar R

module half_adder(
    input a,
    input b,
    output sum,
    output carry
);

    assign sum   = a ^ b;
    assign carry = a & b;

endmodule

module half_subtractor(
    input a,
    input b,
    output diff,
    output borrow
);

    wire nota;

    not(nota, a);
    xor(diff, a, b);
    and(borrow, nota, b);

endmodule

module full_subtractor(
    input a,
    input b,
    input bin,
    output diff,
    output bout
);

    wire hs1opdiff, hs1opborrow;
    wire hs2opdiff, hs2opborrow;

    half_subtractor hs1(
        .a(a),
        .b(b),
        .diff(hs1opdiff),
        .borrow(hs1opborrow)
    );

    half_subtractor hs2(
        .a(hs1opdiff),
        .b(bin),
        .diff(diff),
        .borrow(hs2opborrow)
    );

    or(bout, hs1opborrow, hs2opborrow);

endmodule

module tb_full_subtractor;

reg a, b, bin;
wire diff, bout;

full_subtractor dut(
    .a(a),
    .b(b),
    .bin(bin),
    .diff(diff),
    .bout(bout)
);

initial
begin

    $dumpfile("full_subtractor.vcd");
    $dumpvars(0, tb_full_subtractor);

    $monitor("A=%b B=%b BIN=%b DIFF=%b BOUT=%b",
             a, b, bin, diff, bout);

    a=0; b=0; bin=0; #10;
    a=0; b=0; bin=1; #10;
    a=0; b=1; bin=0; #10;
    a=0; b=1; bin=1; #10;
    a=1; b=0; bin=0; #10;
    a=1; b=0; bin=1; #10;
    a=1; b=1; bin=0; #10;
    a=1; b=1; bin=1; #10;

    $finish;
end

endmodule
