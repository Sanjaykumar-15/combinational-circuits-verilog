// Designed by Sanjaykumar R

module alu_4bit(
    input      [3:0] a,
    input      [3:0] b,
    input      [2:0] sel,
    output reg [4:0] result
);

    always @(*)
    begin
        case (sel)
            3'b000: result = a + b;
            3'b001: result = a - b;
            3'b010: result = {1'b0, (a & b)};
            3'b011: result = {1'b0, (a | b)};
            3'b100: result = {1'b0, (a ^ b)};
            3'b101: result = {1'b0, ~a};
            3'b110: result = {1'b0, a} << 1;
            3'b111: result = {1'b0, a} >> 1;
            default: result = 5'b0;
        endcase
    end

endmodule

module tb_alu_4bit;

reg  [3:0] a, b;
reg  [2:0] sel;
wire [4:0] result;

alu_4bit dut(
    .a(a),
    .b(b),
    .sel(sel),
    .result(result)
);

initial
begin

    $dumpfile("alu_4bit.vcd");
    $dumpvars(0, tb_alu_4bit);

    $monitor("SEL=%b A=%d B=%d RESULT=%d", sel, a, b, result);

    a = 4'd6; b = 4'd3;
    sel = 3'b000; #10;
    sel = 3'b001; #10;
    sel = 3'b010; #10;
    sel = 3'b011; #10;
    sel = 3'b100; #10;
    sel = 3'b101; #10;
    sel = 3'b110; #10;
    sel = 3'b111; #10;

    $finish;
end

endmodule
