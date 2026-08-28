// Designed by Sanjaykumar R

module ripple_block_4bit(
    input      [3:0] a,
    input      [3:0] b,
    input            cin,
    output     [3:0] sum,
    output           cout,
    output           block_propagate
);

    assign {cout, sum} = a + b + cin;
    assign block_propagate = &(a ^ b);  // all bit-wise propagate signals are 1

endmodule

module carry_skip_adder_8bit(
    input      [7:0] a,
    input      [7:0] b,
    input            cin,
    output     [7:0] sum,
    output           cout
);

    wire       c4_ripple, c4_final;
    wire       block0_p, block1_p;
    wire       cout1_ripple;

    ripple_block_4bit block0(
        .a(a[3:0]),
        .b(b[3:0]),
        .cin(cin),
        .sum(sum[3:0]),
        .cout(c4_ripple),
        .block_propagate(block0_p)
    );

    // skip logic: if block0 fully propagates, the carry out of block0
    // equals cin, so we can bypass waiting for its ripple chain
    assign c4_final = block0_p ? cin : c4_ripple;

    ripple_block_4bit block1(
        .a(a[7:4]),
        .b(b[7:4]),
        .cin(c4_final),
        .sum(sum[7:4]),
        .cout(cout1_ripple),
        .block_propagate(block1_p)
    );

    assign cout = cout1_ripple;

endmodule

module tb_carry_skip_adder_8bit;

reg  [7:0] a, b;
reg        cin;
wire [7:0] sum;
wire       cout;
wire [8:0] expected;

carry_skip_adder_8bit dut(
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .cout(cout)
);

assign expected = a + b + cin;

initial
begin

    $dumpfile("carry_skip_adder_8bit.vcd");
    $dumpvars(0, tb_carry_skip_adder_8bit);

    $monitor("A=%d B=%d CIN=%b  SUM=%d COUT=%b  EXPECTED=%d",
               a, b, cin, sum, cout, expected);

    a=8'd15;  b=8'd1;   cin=1'b0; #10;   // block0 all-propagate case
    a=8'd200; b=8'd100; cin=1'b0; #10;
    a=8'd255; b=8'd255; cin=1'b1; #10;
    a=8'd0;   b=8'd0;   cin=1'b0; #10;
    a=8'd128; b=8'd128; cin=1'b0; #10;

    $finish;
end

endmodule
