// Designed by Sanjaykumar R

module non_restoring_divider_4bit(
    input      [3:0] dividend,
    input      [3:0] divisor,
    output     [3:0] quotient,
    output     [3:0] remainder
);

    integer i;
    reg signed [5:0] a;
    reg        [3:0] q;
    reg signed [5:0] m;

    always @(*)
    begin
        a = 6'sd0;
        q = dividend;
        m = {2'b0, divisor};

        for (i = 0; i < 4; i = i + 1)
        begin
            a = {a[4:0], q[3]};
            q = {q[2:0], 1'b0};

            if (a[5] == 1'b0)
                a = a - m;
            else
                a = a + m;

            if (a[5] == 1'b0)
                q[0] = 1'b1;
            else
                q[0] = 1'b0;
        end

        if (a[5] == 1'b1)
            a = a + m;
    end

    assign quotient  = q;
    assign remainder = a[3:0];

endmodule

module tb_non_restoring_divider_4bit;

reg  [3:0] dividend, divisor;
wire [3:0] quotient, remainder;

non_restoring_divider_4bit dut(
    .dividend(dividend),
    .divisor(divisor),
    .quotient(quotient),
    .remainder(remainder)
);

initial
begin

    $dumpfile("non_restoring_divider_4bit.vcd");
    $dumpvars(0, tb_non_restoring_divider_4bit);

    $monitor("DIVIDEND=%d DIVISOR=%d QUOTIENT=%d REMAINDER=%d",
               dividend, divisor, quotient, remainder);

    dividend=4'd9;  divisor=4'd2; #10;
    dividend=4'd15; divisor=4'd4; #10;
    dividend=4'd7;  divisor=4'd3; #10;
    dividend=4'd8;  divisor=4'd8; #10;
    dividend=4'd5;  divisor=4'd7; #10;

    $finish;
end

endmodule
