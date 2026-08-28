// Designed by Sanjaykumar R

module dec_grey(
    input [9:0] num,
    output [9:0] grey
);

    assign grey = num ^ (num >> 1);

endmodule
module tb_dg;
    reg  [9:0] num;
    wire [9:0] grey;

    dec_grey uut(
        .num(num),
        .grey(grey)
    );

    initial begin
        $dumpfile("dec_grey.vcd");
        $dumpvars(0, tb_dg);

        num = 10'd5;
        #1 $display("Decimal: %d | Binary: %b | Gray: %b", num, num, grey);

        num = 10'd6;
        #1 $display("Decimal: %d | Binary: %b | Gray: %b", num, num, grey);

        num = 10'd523;
        #1 $display("Decimal: %d | Binary: %b | Gray: %b", num, num, grey);

        $finish;
    end
endmodule
