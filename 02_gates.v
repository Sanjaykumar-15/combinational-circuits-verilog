// Designed by Sanjaykumar R

module comb_gates(
    output reg and_y,
    output reg or_y,
    output reg nand_y,
    output reg nor_y,
    output reg xor_y,
    output reg xnor_y,
    input a,
    input b
);

always @(a or b)
begin

    and_y  = a & b;
    or_y   = a | b;
    nand_y = ~(a & b);
    nor_y  = ~(a | b);
    xor_y  = a ^ b;
    xnor_y = ~(a ^ b);
end

endmodule

module tb_comb_gates;

reg a, b;
wire and_y, or_y, nand_y, nor_y, xor_y, xnor_y;

comb_gates dut(
    .a(a),
    .b(b),
    .and_y(and_y),
    .or_y(or_y),
    .nand_y(nand_y),
    .nor_y(nor_y),
    .xor_y(xor_y),
    .xnor_y(xnor_y)
);

initial
begin
    $dumpfile("comb_2gates.vcd");
    $dumpvars(0, tb_comb_gates);
    $monitor("a=%b b=%b AND=%b OR=%b NAND=%b NOR=%b XOR=%b XNOR=%b",
             a, b, and_y, or_y, nand_y, nor_y, xor_y, xnor_y);

    a = 0; b = 0; #10;
    a = 0; b = 1; #10;
    a = 1; b = 0; #10;
    a = 1; b = 1; #10;

    $finish;
end

endmodule
