// Designed by Sanjaykumar R

module comb_gates(
    output reg bufif0_y,
    output reg bufif1_y,
    output reg notif0_y,
    output reg notif1_y,
    input a,
    input en
);

    always @(a or en)
    begin
        if (!en)
            bufif0_y = a;
        else
            bufif0_y = 1'bz;

        if (en)
            bufif1_y = a;
        else
            bufif1_y = 1'bz;

        if (!en)
            notif0_y = ~a;
        else
            notif0_y = 1'bz;

        if (en)
            notif1_y = ~a;
        else
            notif1_y = 1'bz;
    end

endmodule

module tb_comb_gates;

reg a, en;
wire bufif0_y, bufif1_y, notif0_y, notif1_y;

comb_gates dut(
    .a(a),
    .en(en),
    .bufif0_y(bufif0_y),
    .bufif1_y(bufif1_y),
    .notif0_y(notif0_y),
    .notif1_y(notif1_y)
);

initial
begin

    $dumpfile("comb_gates.vcd");
    $dumpvars(0, tb_comb_gates);

    $monitor("a=%b en=%b BUFIF0=%b BUFIF1=%b NOTIF0=%b NOTIF1=%b",
             a, en, bufif0_y, bufif1_y, notif0_y, notif1_y);

    a = 0; en = 0; #10;
    a = 0; en = 1; #10;
    a = 1; en = 0; #10;
    a = 1; en = 1; #10;

    a = 0; en = 0; #10;
    a = 0; en = 1; #10;
    a = 1; en = 0; #10;
    a = 1; en = 1; #10;

    $finish;
end

endmodule
