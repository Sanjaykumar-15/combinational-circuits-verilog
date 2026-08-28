// Designed by Sanjaykumar R

module bcd_to_xs3(
    input  [3:0] bcd,
    output reg [3:0] xs3
);

always @(*)
begin
    case(bcd)
        4'b0000: xs3 = 4'b0011;
        4'b0001: xs3 = 4'b0100;
        4'b0010: xs3 = 4'b0101;
        4'b0011: xs3 = 4'b0110;
        4'b0100: xs3 = 4'b0111;
        4'b0101: xs3 = 4'b1000;
        4'b0110: xs3 = 4'b1001;
        4'b0111: xs3 = 4'b1010;
        4'b1000: xs3 = 4'b1011;
        4'b1001: xs3 = 4'b1100;

        default: xs3 = 4'bxxxx;
    endcase
end

endmodule

module tb_bcd_to_xs3;

reg [3:0] bcd;
wire [3:0] xs3;

bcd_to_xs3 dut(
    .bcd(bcd),
    .xs3(xs3)
);

initial
begin

    $dumpfile("bcd_to_xs3.vcd");
    $dumpvars(0, tb_bcd_to_xs3);

    $monitor("BCD=%b XS3=%b", bcd, xs3);

    bcd = 4'b0000; #10;
    bcd = 4'b0001; #10;
    bcd = 4'b0010; #10;
    bcd = 4'b0011; #10;
    bcd = 4'b0100; #10;
    bcd = 4'b0101; #10;
    bcd = 4'b0110; #10;
    bcd = 4'b0111; #10;
    bcd = 4'b1000; #10;
    bcd = 4'b1001; #10;

    $finish;
end

endmodule
