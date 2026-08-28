// Designed by Sanjaykumar R

module restoring_divider_4bit(
    input      [3:0] dividend,
    input      [3:0] divisor,
    output     [3:0] quotient,
    output     [3:0] remainder
);

    integer i;
    reg [4:0] a;
    reg [3:0] q;
    reg [4:0] m;
    reg [4:0] a_shifted;

    always @(*)
    begin
        a = 5'b0;
        q = dividend;
        m = {1'b0, divisor};

        for (i = 0; i < 4; i = i + 1)
        begin
            a_shifted = {a[3:0], q[3]};
            q         = {q[2:0], 1'b0};

            if (a_shifted >= m)
            begin
                a    = a_shifted - m;
                q[0] = 1'b1;
            end
            else
            begin
                a = a_shifted;
            end
        end
    end

    assign quotient  = q;
    assign remainder = a[3:0];

endmodule

module tb_restoring_divider_4bit;

reg  [3:0] dividend, divisor;
wire [3:0] quotient, remainder;

restoring_divider_4bit dut(
    .dividend(dividend),
    .divisor(divisor),
    .quotient(quotient),
    .remainder(remainder)
);

initial
begin

    $dumpfile("restoring_divider_4bit.vcd");
    $dumpvars(0, tb_restoring_divider_4bit);

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
