// Designed by Sanjaykumar R

module encoder_2_to_1(
    input  [1:0] d,
    output       y
);

    assign y = d[1];

endmodule

module tb_encoder_2_to_1;

reg  [1:0] d;
wire       y;

encoder_2_to_1 dut(
    .d(d),
    .y(y)
);

initial
begin

    $dumpfile("encoder_2_to_1.vcd");
    $dumpvars(0, tb_encoder_2_to_1);

    $monitor("D=%b Y=%b", d, y);

    d = 2'b01; #10;
    d = 2'b10; #10;

    $finish;

end

endmodule
