// Designed by Sanjaykumar R

module demux_1_to_2(
    input  d,
    input  s,
    output [1:0] y
);

    assign y[0] = d & ~s;
    assign y[1] = d & s;

endmodule

module tb_demux_1_to_2;

reg d;
reg s;

wire [1:0] y;

demux_1_to_2 dut(
    .d(d),
    .s(s),
    .y(y)
);

initial
begin

    $dumpfile("demux_1_to_2.vcd");
    $dumpvars(0, tb_demux_1_to_2);

    $monitor("D=%b S=%b Y=%b", d, s, y);

    d=0; s=0; #10;
    d=1; s=0; #10;
    d=1; s=1; #10;
    d=0; s=1; #10;

    $finish;

end

endmodule
