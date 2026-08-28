// Designed by Sanjaykumar R

module carry_look_ahead_adder_4(
    input  [3:0] a,
    input  [3:0] b,
    input        cin,
    output [3:0] sum,
    output       cout
);

    wire [3:0] p;
    wire [3:0] g;
    wire c1, c2, c3;

    assign p[0] = a[0] ^ b[0];
    assign p[1] = a[1] ^ b[1];
    assign p[2] = a[2] ^ b[2];
    assign p[3] = a[3] ^ b[3];

    assign g[0] = a[0] & b[0];
    assign g[1] = a[1] & b[1];
    assign g[2] = a[2] & b[2];
    assign g[3] = a[3] & b[3];

    assign c1 = g[0] |
                (p[0] & cin);

    assign c2 = g[1] |
                (p[1] & g[0]) |
                (p[1] & p[0] & cin);

    assign c3 = g[2] |
                (p[2] & g[1]) |
                (p[2] & p[1] & g[0]) |
                (p[2] & p[1] & p[0] & cin);

    assign cout = g[3] |
                  (p[3] & g[2]) |
                  (p[3] & p[2] & g[1]) |
                  (p[3] & p[2] & p[1] & g[0]) |
                  (p[3] & p[2] & p[1] & p[0] & cin);

    assign sum[0] = p[0] ^ cin;
    assign sum[1] = p[1] ^ c1;
    assign sum[2] = p[2] ^ c2;
    assign sum[3] = p[3] ^ c3;

endmodule

module tb_carry_look_ahead_adder_4;

    reg  [3:0] a;
    reg  [3:0] b;
    reg        cin;

    wire [3:0] sum;
    wire       cout;

    carry_look_ahead_adder_4 dut(
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    initial
    begin

        $dumpfile("carry_look_ahead_adder_4.vcd");
        $dumpvars(0, tb_carry_look_ahead_adder_4);

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

        a = 4'b0111;
        b = 4'b0001;
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
