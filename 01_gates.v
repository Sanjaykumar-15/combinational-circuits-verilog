// Designed by Sanjaykumar R

module comb_gates(
    output reg not_y,
    output reg buff_y,
    input a
);

    always @(a)
    begin

        not_y  = ~a;
        buff_y = a;

    end

endmodule

module tb_comb_gates;

reg a;
wire not_y, buff_y;

comb_gates dut(
    .a(a),
    .not_y(not_y),
    .buff_y(buff_y)
);

initial
begin
    $dumpfile("comb_gates.vcd");
    $dumpvars(0, tb_comb_gates);
    $monitor("a=%b NOT=%b BUFF=%b",
             a, not_y, buff_y);

    a = 0; #10;
    a = 1; #10;

    $finish;
end

endmodule
