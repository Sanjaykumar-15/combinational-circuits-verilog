// Designed by Sanjaykumar R

module booth_multiplier_4bit(
    input      signed [3:0] a,
    input      signed [3:0] b,
    output reg signed [7:0] product
);

    integer i;
    reg signed [9:0] acc;
    reg signed [4:0] m, s;
    reg q_1;

    always @(*)
    begin
        m    = {a[3], a};
        s    = -m;
        acc  = {5'b0, b, 1'b0};
        q_1  = 1'b0;

        for (i = 0; i < 4; i = i + 1)
        begin
            case (acc[1:0])
                2'b01: acc[9:5] = acc[9:5] + m;
                2'b10: acc[9:5] = acc[9:5] + s;
                default: acc[9:5] = acc[9:5];
            endcase
            acc = {acc[9], acc[9:1]};
        end

        product = acc[8:1];
    end

endmodule

module tb_booth_multiplier_4bit;

reg  signed [3:0] a, b;
wire signed [7:0] product;

booth_multiplier_4bit dut(
    .a(a),
    .b(b),
    .product(product)
);

initial
begin

    $dumpfile("booth_multiplier_4bit.vcd");
    $dumpvars(0, tb_booth_multiplier_4bit);

    $monitor("A=%d B=%d PRODUCT=%d", a, b, product);

    a=4'sd3;  b=4'sd5;  #10;
    a=-4'sd3; b=4'sd5;  #10;
    a=4'sd3;  b=-4'sd5; #10;
    a=-4'sd3; b=-4'sd5; #10;
    a=4'sd7;  b=-4'sd8; #10;

    $finish;
end

endmodule
