// Designed by Sanjaykumar R

module decoder_2_to_4(
    input        en,
    input  [1:0] a,
    output [3:0] y
);

    assign y[0] = en & ~a[1] & ~a[0];
    assign y[1] = en & ~a[1] &  a[0];
    assign y[2] = en &  a[1] & ~a[0];
    assign y[3] = en &  a[1] &  a[0];

endmodule

module tb_decoder_2_to_4;

reg        en;
reg  [1:0] a;
wire [3:0] y;

decoder_2_to_4 dut(
    .en(en),
    .a(a),
    .y(y)
);

initial
begin

    $dumpfile("decoder_2_to_4.vcd");
    $dumpvars(0, tb_decoder_2_to_4);

    $monitor("EN=%b A=%b Y=%b", en, a, y);

    en = 0; a = 2'b00; #10;
    en = 0; a = 2'b01; #10;
    en = 0; a = 2'b10; #10;
    en = 0; a = 2'b11; #10;

    en = 1; a = 2'b00; #10;
    en = 1; a = 2'b01; #10;
    en = 1; a = 2'b10; #10;
    en = 1; a = 2'b11; #10;

    $finish;

end

endmodule
