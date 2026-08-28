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

    wire c1, c2, c3;

    full_adder_4 fa0(
        .a(a[3:0]),
        .b(b[3:0]),
        .cin(cin),
        .sum(sum[3:0]),
        .cout(c1)
    );

    full_adder_4 fa1(
        .a(a[7:4]),
        .b(b[7:4]),
        .cin(c1),
        .sum(sum[7:4]),
        .cout(c2)
    );

    full_adder_4 fa2(
        .a(a[11:8]),
        .b(b[11:8]),
        .cin(c2),
        .sum(sum[11:8]),
        .cout(c3)
    );

    full_adder_4 fa3(
        .a(a[15:12]),
        .b(b[15:12]),
        .cin(c3),
        .sum(sum[15:12]),
        .cout(cout)
    );

endmodule

module full_adder_32(
    input  [31:0] a,
    input  [31:0] b,
    input         cin,
    output [31:0] sum,
    output        cout
);

    wire c16;

    full_adder_16 fa16_0(
        .a(a[15:0]),
        .b(b[15:0]),
        .cin(cin),
        .sum(sum[15:0]),
        .cout(c16)
    );

    full_adder_16 fa16_1(
        .a(a[31:16]),
        .b(b[31:16]),
        .cin(c16),
        .sum(sum[31:16]),
        .cout(cout)
    );

endmodule

module full_adder_64(
    input  [63:0] a,
    input  [63:0] b,
    input         cin,
    output [63:0] sum,
    output        cout
);

    wire c32;

    full_adder_32 fa32_0(
        .a(a[31:0]),
        .b(b[31:0]),
        .cin(cin),
        .sum(sum[31:0]),
        .cout(c32)
    );

    full_adder_32 fa32_1(
        .a(a[63:32]),
        .b(b[63:32]),
        .cin(c32),
        .sum(sum[63:32]),
        .cout(cout)
    );

endmodule

module tb_full_adder_64;

reg  [63:0] a, b;
reg         cin;
wire [63:0] sum;
wire        cout;

full_adder_64 dut(
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .cout(cout)
);

initial
begin

    $dumpfile("full_adder_64.vcd");
    $dumpvars(0, tb_full_adder_64);

    $monitor("A=%h B=%h CIN=%b SUM=%h COUT=%b",
             a, b, cin, sum, cout);

    a = 64'h0000000000000000;
    b = 64'h0000000000000000;
    cin = 0;
    #10;

    a = 64'h0000000000000001;
    b = 64'h0000000000000001;
    cin = 0;
    #10;

    a = 64'h00000000FFFFFFFF;
    b = 64'h0000000000000001;
    cin = 0;
    #10;

    a = 64'h123456789ABCDEF0;
    b = 64'h1111111111111111;
    cin = 0;
    #10;

    a = 64'hFFFFFFFFFFFFFFFF;
    b = 64'h0000000000000001;
    cin = 0;
    #10;

    $finish;
end

endmodule
