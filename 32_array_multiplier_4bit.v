// Designed by Sanjaykumar R

module array_multiplier_4bit(
    input      [3:0] a,
    input      [3:0] b,
    output     [7:0] product
);

    wire [3:0] pp0, pp1, pp2, pp3;
    wire [3:0] sum1, sum2, sum3;
    wire [3:0] carry1, carry2, carry3;

    assign pp0 = a & {4{b[0]}};
    assign pp1 = a & {4{b[1]}};
    assign pp2 = a & {4{b[2]}};
    assign pp3 = a & {4{b[3]}};

    assign product[0] = pp0[0];

    wire [3:0] add1_in;
    assign add1_in = {1'b0, pp0[3:1]};
    assign {carry1, sum1} = add1_in + pp1;
    assign product[1] = sum1[0];

    wire [3:0] add2_in;
    assign add2_in = {carry1[0], sum1[3:1]};
    assign {carry2, sum2} = add2_in + pp2;
    assign product[2] = sum2[0];

    wire [3:0] add3_in;
    assign add3_in = {carry2[0], sum2[3:1]};
    assign {carry3, sum3} = add3_in + pp3;
    assign product[3] = sum3[0];

    assign product[7:4] = {carry3[0], sum3[3:1]};

endmodule

module tb_array_multiplier_4bit;

reg  [3:0] a, b;
wire [7:0] product;

array_multiplier_4bit dut(
    .a(a),
    .b(b),
    .product(product)
);

initial
begin

    $dumpfile("array_multiplier_4bit.vcd");
    $dumpvars(0, tb_array_multiplier_4bit);

    $monitor("A=%d B=%d PRODUCT=%d", a, b, product);

    a=4'd3;  b=4'd5;  #10;
    a=4'd7;  b=4'd6;  #10;
    a=4'd15; b=4'd15; #10;
    a=4'd0;  b=4'd9;  #10;
    a=4'd9;  b=4'd0;  #10;

    $finish;
end

endmodule
