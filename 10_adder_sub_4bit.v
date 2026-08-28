// Designed by Sanjaykumar R

module full_adder(
    input a,
    input b,
    input cin,
    output sum,
    output cout
);

    assign sum  = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (a & cin);

endmodule

module parallel_adder_subtractor_4(
    input  [3:0] a,
    input  [3:0] b,
    input        m,
    output [3:0] result,
    output       cout
);

    wire [3:0] bx;
    wire c1, c2, c3;

    xor(bx[0], b[0], m);
    xor(bx[1], b[1], m);
    xor(bx[2], b[2], m);
    xor(bx[3], b[3], m);

    full_adder fa0(
        .a(a[0]),
        .b(bx[0]),
        .cin(m),
        .sum(result[0]),
        .cout(c1)
    );

    full_adder fa1(
        .a(a[1]),
        .b(bx[1]),
        .cin(c1),
        .sum(result[1]),
        .cout(c2)
    );

    full_adder fa2(
        .a(a[2]),
        .b(bx[2]),
        .cin(c2),
        .sum(result[2]),
        .cout(c3)
    );

    full_adder fa3(
        .a(a[3]),
        .b(bx[3]),
        .cin(c3),
        .sum(result[3]),
        .cout(cout)
    );

endmodule

module tb_parallel_adder_subtractor_4;

reg  [3:0] a, b;
reg        m;
wire [3:0] result;
wire       cout;

parallel_adder_subtractor_4 dut(
    .a(a),
    .b(b),
    .m(m),
    .result(result),
    .cout(cout)
);

initial
begin

    $dumpfile("parallel_adder_subtractor_4.vcd");
    $dumpvars(0, tb_parallel_adder_subtractor_4);

    $monitor("A=%b B=%b M=%b RESULT=%b COUT=%b",
             a, b, m, result, cout);

    a=4'b0101; b=4'b0011; m=0; #10;
    a=4'b0111; b=4'b0001; m=0; #10;

    a=4'b0101; b=4'b0011; m=1; #10;
    a=4'b1001; b=4'b0011; m=1; #10;
    a=4'b0011; b=4'b0101; m=1; #10;

    $finish;
end

endmodule
