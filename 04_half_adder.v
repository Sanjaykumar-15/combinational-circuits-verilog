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

module tb_half_adder;

reg a, b;
wire sum, carry;

half_adder dut(
    .a(a),
    .b(b),
    .sum(sum),
    .carry(carry)
);

initial
begin

    $dumpfile("half_adder.vcd");
    $dumpvars(0, tb_half_adder);

    $monitor("A=%b B=%b SUM=%b CARRY=%b",
             a, b, sum, carry);

    a = 0; b = 0; #10;
    a = 0; b = 1; #10;
    a = 1; b = 0; #10;
    a = 1; b = 1; #10;

    $finish;
end

endmodule
