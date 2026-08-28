// Designed by Sanjaykumar R

module full_adder(
    input  a,
    input  b,
    input  cin,
    output sum,
    output cout
);

    assign sum  = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (a & cin);

endmodule

module full_adder_4(
    input  [3:0] a,
    input  [3:0] b,
    input        cin,
    output [3:0] sum,
    output       cout
);

    wire c1, c2, c3;

    full_adder fa0(
        .a(a[0]),
        .b(b[0]),
        .cin(cin),
        .sum(sum[0]),
        .cout(c1)
    );

    full_adder fa1(
        .a(a[1]),
        .b(b[1]),
        .cin(c1),
        .sum(sum[1]),
        .cout(c2)
    );

    full_adder fa2(
        .a(a[2]),
        .b(b[2]),
        .cin(c2),
        .sum(sum[2]),
        .cout(c3)
    );

    full_adder fa3(
        .a(a[3]),
        .b(b[3]),
        .cin(c3),
        .sum(sum[3]),
        .cout(cout)
    );

endmodule

module tb_full_adder_4;

    reg  [3:0] a;
    reg  [3:0] b;
    reg        cin;

    wire [3:0] sum;
    wire       cout;

    full_adder_4 dut(
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    initial
    begin

        $dumpfile("full_adder_4.vcd");
        $dumpvars(0, tb_full_adder_4);

        $monitor("A=%b B=%b CIN=%b SUM=%b COUT=%b",
                 a, b, cin, sum, cout);

        a = 4'b0000;
        b = 4'b0000;
        cin = 0;
        #10;

        a = 4'b0001;
        b = 4'b0001;
        cin = 0;
        #10;

        a = 4'b0011;
        b = 4'b0010;
        cin = 0;
        #10;

        a = 4'b0101;
        b = 4'b0011;
        cin = 0;
        #10;

        a = 4'b1111;
        b = 4'b0001;
        cin = 0;
        #10;

        a = 4'b1111;
        b = 4'b1111;
        cin = 1;
        #10;

        $finish;

    end

endmodule
