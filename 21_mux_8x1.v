// Designed by Sanjaykumar R

module mux_8_to_1(
    input  [7:0] d,
    input  [2:0] s,
    output y
);

    assign y = d[s];

endmodule

module tb_mux_8_to_1;

    reg  [7:0] d;
    reg  [2:0] s;

    wire y;

    mux_8_to_1 dut(
        .d(d),
        .s(s),
        .y(y)
    );

    initial
    begin

        $dumpfile("mux_8_to_1.vcd");
        $dumpvars(0, tb_mux_8_to_1);

        $monitor("D=%b S=%b Y=%b",
                 d, s, y);

        d = 8'b10101010; s = 3'b000; #10;
        d = 8'b10101010; s = 3'b001; #10;
        d = 8'b10101010; s = 3'b010; #10;
        d = 8'b10101010; s = 3'b011; #10;
        d = 8'b10101010; s = 3'b100; #10;
        d = 8'b10101010; s = 3'b101; #10;
        d = 8'b10101010; s = 3'b110; #10;
        d = 8'b10101010; s = 3'b111; #10;

        $finish;

    end

endmodule
