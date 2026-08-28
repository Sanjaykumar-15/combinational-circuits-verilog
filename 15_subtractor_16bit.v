// Designed by Sanjaykumar R

module full_subtractor(
    input a,
    input b,
    input bin,
    output diff,
    output bout
);

    assign diff = a ^ b ^ bin;
    assign bout = (~a & b) | (~a & bin) | (b & bin);

endmodule
module full_subtractor_4(
    input  [3:0] a,
    input  [3:0] b,
    input        bin,
    output [3:0] diff,
    output       bout
);

    wire b1, b2, b3;

    full_subtractor fs0(
        .a(a[0]),
        .b(b[0]),
        .bin(bin),
        .diff(diff[0]),
        .bout(b1)
    );

    full_subtractor fs1(
        .a(a[1]),
        .b(b[1]),
        .bin(b1),
        .diff(diff[1]),
        .bout(b2)
    );

    full_subtractor fs2(
        .a(a[2]),
        .b(b[2]),
        .bin(b2),
        .diff(diff[2]),
        .bout(b3)
    );

    full_subtractor fs3(
        .a(a[3]),
        .b(b[3]),
        .bin(b3),
        .diff(diff[3]),
        .bout(bout)
    );

endmodule

module full_subtractor_16(
    input  [15:0] a,
    input  [15:0] b,
    input         bin,
    output [15:0] diff,
    output        bout
);

    wire b4, b8, b12;

    full_subtractor_4 fs4_0(
        .a(a[3:0]),
        .b(b[3:0]),
        .bin(bin),
        .diff(diff[3:0]),
        .bout(b4)
    );

    full_subtractor_4 fs4_1(
        .a(a[7:4]),
        .b(b[7:4]),
        .bin(b4),
        .diff(diff[7:4]),
        .bout(b8)
    );

    full_subtractor_4 fs4_2(
        .a(a[11:8]),
        .b(b[11:8]),
        .bin(b8),
        .diff(diff[11:8]),
        .bout(b12)
    );

    full_subtractor_4 fs4_3(
        .a(a[15:12]),
        .b(b[15:12]),
        .bin(b12),
        .diff(diff[15:12]),
        .bout(bout)
    );

endmodule

module tb_full_subtractor_16;

reg  [15:0] a, b;
reg         bin;
wire [15:0] diff;
wire        bout;

full_subtractor_16 dut(
    .a(a),
    .b(b),
    .bin(bin),
    .diff(diff),
    .bout(bout)
);

initial
begin

    $dumpfile("full_subtractor_16.vcd");
    $dumpvars(0, tb_full_subtractor_16);

    $monitor("A=%h B=%h BIN=%b DIFF=%h BOUT=%b",
             a, b, bin, diff, bout);

    a = 16'h0000; b = 16'h0000; bin = 0; #10;
    a = 16'h0001; b = 16'h0001; bin = 0; #10;
    a = 16'h0010; b = 16'h0001; bin = 0; #10;
    a = 16'h1234; b = 16'h1111; bin = 0; #10;
    a = 16'h0000; b = 16'h0001; bin = 0; #10;
    a = 16'hFFFF; b = 16'h0001; bin = 0; #10;

    $finish;
end

endmodule
