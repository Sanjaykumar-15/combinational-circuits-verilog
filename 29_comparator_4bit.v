// Designed by Sanjaykumar R

module comparator_4bit(
    input  [3:0] a,
    input  [3:0] b,
    output       gt,
    output       lt,
    output       eq
);

    assign gt = (a > b);
    assign lt = (a < b);
    assign eq = (a == b);

endmodule

module tb_comparator_4bit;

reg  [3:0] a, b;
wire gt, lt, eq;

comparator_4bit dut(
    .a(a),
    .b(b),
    .gt(gt),
    .lt(lt),
    .eq(eq)
);

initial
begin

    $dumpfile("comparator_4bit.vcd");
    $dumpvars(0, tb_comparator_4bit);

    $monitor("A=%d B=%d GT=%b LT=%b EQ=%b", a, b, gt, lt, eq);

    a=4'd5;  b=4'd3;  #10;
    a=4'd3;  b=4'd5;  #10;
    a=4'd7;  b=4'd7;  #10;
    a=4'd0;  b=4'd15; #10;
    a=4'd15; b=4'd0;  #10;

    $finish;
end

endmodule
