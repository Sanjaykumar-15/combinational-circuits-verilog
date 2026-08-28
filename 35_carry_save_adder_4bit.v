// Designed by Sanjaykumar R

module carry_save_adder_4bit(
    input      [3:0] x,
    input      [3:0] y,
    input      [3:0] z,
    output     [3:0] sum,
    output     [3:0] carry
);

    assign sum   = x ^ y ^ z;
    assign carry = (x & y) | (y & z) | (x & z);

endmodule

module tb_carry_save_adder_4bit;

reg  [3:0] x, y, z;
wire [3:0] sum, carry;
wire [4:0] final_result;

carry_save_adder_4bit dut(
    .x(x),
    .y(y),
    .z(z),
    .sum(sum),
    .carry(carry)
);

assign final_result = sum + {carry, 1'b0};

initial
begin

    $dumpfile("carry_save_adder_4bit.vcd");
    $dumpvars(0, tb_carry_save_adder_4bit);

    $monitor("X=%d Y=%d Z=%d SUM=%b CARRY=%b FINAL(sum+2*carry)=%d",
               x, y, z, sum, carry, final_result);

    x=4'd3; y=4'd5; z=4'd2; #10;
    x=4'd7; y=4'd6; z=4'd1; #10;
    x=4'd9; y=4'd4; z=4'd3; #10;

    $finish;
end

endmodule
