// Designed by Sanjaykumar R

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

module tb_half_subtractor;

reg a, b;
wire diff, borrow;

half_subtractor dut(
    .a(a),
    .b(b),
    .diff(diff),
    .borrow(borrow)
);

initial
begin

    $dumpfile("half_subtractor.vcd");
    $dumpvars(0, tb_half_subtractor);

    $monitor("A=%b B=%b DIFF=%b BORROW=%b",
             a, b, diff, borrow);

    a=0; b=0; #10;
    a=0; b=1; #10;
    a=1; b=0; #10;
    a=1; b=1; #10;

    $finish;
end

endmodule
