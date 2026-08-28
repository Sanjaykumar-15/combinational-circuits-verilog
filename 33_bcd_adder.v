// Designed by Sanjaykumar R

module bcd_adder(
    input      [3:0] a,
    input      [3:0] b,
    input            cin,
    output     [3:0] sum,
    output           cout
);

    wire [4:0] binary_sum;
    wire [4:0] corrected_sum;
    wire       needs_correction;

    assign binary_sum      = a + b + cin;
    assign needs_correction = (binary_sum > 5'd9);
    assign corrected_sum   = needs_correction ? (binary_sum + 5'd6) : binary_sum;

    assign sum  = corrected_sum[3:0];
    assign cout = needs_correction | corrected_sum[4];

endmodule

module tb_bcd_adder;

reg  [3:0] a, b;
reg        cin;
wire [3:0] sum;
wire       cout;

bcd_adder dut(
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .cout(cout)
);

initial
begin

    $dumpfile("bcd_adder.vcd");
    $dumpvars(0, tb_bcd_adder);

    $monitor("A=%d B=%d CIN=%b SUM=%d COUT=%b", a, b, cin, sum, cout);

    a=4'd5; b=4'd3; cin=1'b0; #10;
    a=4'd9; b=4'd8; cin=1'b0; #10;
    a=4'd6; b=4'd7; cin=1'b0; #10;
    a=4'd9; b=4'd9; cin=1'b1; #10;
    a=4'd0; b=4'd0; cin=1'b0; #10;

    $finish;
end

endmodule
