// Designed by Sanjaykumar R

module csa_8bit(
    input      [7:0] x,
    input      [7:0] y,
    input      [7:0] z,
    output     [7:0] sum,
    output     [7:0] carry
);
    assign sum   = x ^ y ^ z;
    assign carry = (x & y) | (y & z) | (x & z);
endmodule

module wallace_tree_multiplier_4bit(
    input      [3:0] a,
    input      [3:0] b,
    output     [7:0] product
);

    wire [7:0] pp0, pp1, pp2, pp3;

    assign pp0 = {4'b0, (a & {4{b[0]}})};
    assign pp1 = {3'b0, (a & {4{b[1]}}), 1'b0};
    assign pp2 = {2'b0, (a & {4{b[2]}}), 2'b0};
    assign pp3 = {1'b0, (a & {4{b[3]}}), 3'b0};

    wire [7:0] sum1, carry1;
    csa_8bit stage1(.x(pp0), .y(pp1), .z(pp2), .sum(sum1), .carry(carry1));

    wire [7:0] sum2, carry2;
    csa_8bit stage2(.x(sum1), .y({carry1[6:0], 1'b0}), .z(pp3), .sum(sum2), .carry(carry2));

    assign product = sum2 + {carry2[6:0], 1'b0};

endmodule

module tb_wallace_tree_multiplier_4bit;

reg  [3:0] a, b;
wire [7:0] product;
integer errors;

wallace_tree_multiplier_4bit dut(
    .a(a),
    .b(b),
    .product(product)
);

initial
begin

    $dumpfile("wallace_tree_multiplier_4bit.vcd");
    $dumpvars(0, tb_wallace_tree_multiplier_4bit);

    errors = 0;

    a=4'd3;  b=4'd5;  #10; $display("A=%d B=%d PRODUCT=%d EXPECTED=%d", a, b, product, ({4'b0,a}*{4'b0,b})); if (product !== ({4'b0,a}*{4'b0,b})) errors = errors + 1;
    a=4'd7;  b=4'd6;  #10; $display("A=%d B=%d PRODUCT=%d EXPECTED=%d", a, b, product, ({4'b0,a}*{4'b0,b})); if (product !== ({4'b0,a}*{4'b0,b})) errors = errors + 1;
    a=4'd15; b=4'd15; #10; $display("A=%d B=%d PRODUCT=%d EXPECTED=%d", a, b, product, ({4'b0,a}*{4'b0,b})); if (product !== ({4'b0,a}*{4'b0,b})) errors = errors + 1;
    a=4'd9;  b=4'd9;  #10; $display("A=%d B=%d PRODUCT=%d EXPECTED=%d", a, b, product, ({4'b0,a}*{4'b0,b})); if (product !== ({4'b0,a}*{4'b0,b})) errors = errors + 1;
    a=4'd12; b=4'd11; #10; $display("A=%d B=%d PRODUCT=%d EXPECTED=%d", a, b, product, ({4'b0,a}*{4'b0,b})); if (product !== ({4'b0,a}*{4'b0,b})) errors = errors + 1;

    $display("TOTAL ERRORS = %d", errors);

    $finish;
end

endmodule
