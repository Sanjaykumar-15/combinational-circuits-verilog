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

module full_adder_16(
    input  [15:0] a,
    input  [15:0] b,
    input         cin,
    output [15:0] sum,
    output        cout
);

    wire c4, c8, c12;

    full_adder_4 fa4_0(
        .a(a[3:0]),
        .b(b[3:0]),
        .cin(cin),
        .sum(sum[3:0]),
        .cout(c4)
    );

    full_adder_4 fa4_1(
        .a(a[7:4]),
        .b(b[7:4]),
        .cin(c4),
        .sum(sum[7:4]),
        .cout(c8)
    );

    full_adder_4 fa4_2(
        .a(a[11:8]),
        .b(b[11:8]),
        .cin(c8),
        .sum(sum[11:8]),
        .cout(c12)
    );

    full_adder_4 fa4_3(
        .a(a[15:12]),
        .b(b[15:12]),
        .cin(c12),
        .sum(sum[15:12]),
        .cout(cout)
    );

endmodule

module tb_full_adder_16;

reg  [15:0] a, b;
reg         cin;
wire [15:0] sum;
wire        cout;

full_adder_16 dut(
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .cout(cout)
);

initial
begin
    $dumpfile("full_adder_16.vcd");
    $dumpvars(0, tb_full_adder_16);

    $monitor("A=%h B=%h CIN=%b SUM=%h COUT=%b",
             a, b, cin, sum, cout);

    a = 16'h0000; b = 16'h0000; cin = 0; #10;
    a = 16'h0001; b = 16'h0001; cin = 0; #10;
    a = 16'h00FF; b = 16'h0001; cin = 0; #10;
    a = 16'h1234; b = 16'h5678; cin = 0; #10;
    a = 16'hFFFF; b = 16'h0001; cin = 0; #10;

    $finish;
end

endmodule
