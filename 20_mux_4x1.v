// Designed by Sanjaykumar R

module mux_4_to_1(
    input  [3:0] d,
    input  [1:0] s,
    output y
);

    assign y = s[1] ? (s[0] ? d[3] : d[2])
                    : (s[0] ? d[1] : d[0]);

endmodule

module tb_mux_4_to_1;

    reg  [3:0] d;
    reg  [1:0] s;

    wire y;

    mux_4_to_1 dut(
        .d(d),
        .s(s),
        .y(y)
    );

    initial
    begin

        $dumpfile("mux_4_to_1.vcd");
        $dumpvars(0, tb_mux_4_to_1);

        $monitor("D=%b S=%b Y=%b",
                 d, s, y);

        d = 4'b1010; s = 2'b00; #10;
        d = 4'b1010; s = 2'b01; #10;
        d = 4'b1010; s = 2'b10; #10;
        d = 4'b1010; s = 2'b11; #10;

        d = 4'b0101; s = 2'b00; #10;
        d = 4'b0101; s = 2'b01; #10;
        d = 4'b0101; s = 2'b10; #10;
        d = 4'b0101; s = 2'b11; #10;

        $finish;

    end

endmodule
