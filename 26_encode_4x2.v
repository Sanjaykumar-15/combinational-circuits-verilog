// Designed by Sanjaykumar R

module encoder_4_to_2(
    input  [3:0] d,
    output [1:0] y
);

    assign y[1] = d[2] | d[3];
    assign y[0] = d[1] | d[3];

endmodule

module tb_encoder_4_to_2;

reg  [3:0] d;
wire [1:0] y;

encoder_4_to_2 dut(
    .d(d),
    .y(y)
);

initial
begin

    $dumpfile("encoder_4_to_2.vcd");
    $dumpvars(0, tb_encoder_4_to_2);

    $monitor("D=%b Y=%b", d, y);

    d = 4'b0001; #10;
    d = 4'b0010; #10;
    d = 4'b0100; #10;
    d = 4'b1000; #10;

    $finish;

end

endmodule
