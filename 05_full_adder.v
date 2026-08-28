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

module full_adder_own(input a, b, cin,output sum, carry);
    assign sum = a ^ b ^ c;
    assign carry = (a & b)|(b & c)|(a & c);
endmodule

module full_adder(
    input a,
    input b,
    input cin,
    output sum,
    output carry
);

    wire ha1opsum, ha1opcarry, ha2opsum, ha2opcarry;

     half_adder ha1(
        .a(a),
        .b(b),
        .sum(ha1opsum),
        .carry(ha1opcarry)
     );

     half_adder ha2(
         .a(ha1opsum),
         .b(cin),
         .sum(sum),
         .carry(ha2opcarry)
     );

     or(carry, ha1opcarry, ha2opcarry);
endmodule

module tb_full_adder;

reg a, b, cin;
wire sum, carry;

full_adder dut(
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .carry(carry)
);

initial
begin

    $dumpfile("full_adder.vcd");
    $dumpvars(0, tb_full_adder);

    $monitor("A=%b B=%b CIN=%b SUM=%b CARRY=%b",
             a, b, cin, sum, carry);

    a=0; b=0; cin=0; #10;
    a=0; b=0; cin=1; #10;
    a=0; b=1; cin=0; #10;
    a=0; b=1; cin=1; #10;
    a=1; b=0; cin=0; #10;
    a=1; b=0; cin=1; #10;
    a=1; b=1; cin=0; #10;
    a=1; b=1; cin=1; #10;

    $finish;
end

endmodule
