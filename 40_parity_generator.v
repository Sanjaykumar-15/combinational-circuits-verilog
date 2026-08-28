// Designed by Sanjaykumar R

module parity_generator(
    input      [7:0] data,
    input            odd_even,  // 0 = generate even parity bit, 1 = generate odd parity bit
    output           parity_bit
);

    assign parity_bit = odd_even ? ~(^data) : (^data);

endmodule

module tb_parity_generator;

reg  [7:0] data;
reg        odd_even;
wire       parity_bit;

parity_generator dut(
    .data(data),
    .odd_even(odd_even),
    .parity_bit(parity_bit)
);

initial
begin

    $dumpfile("parity_generator.vcd");
    $dumpvars(0, tb_parity_generator);

    $monitor("DATA=%b ODD_EVEN=%b PARITY_BIT=%b", data, odd_even, parity_bit);

    data = 8'b0000_0111; odd_even = 1'b0; #10;
    data = 8'b0000_0111; odd_even = 1'b1; #10;
    data = 8'b1111_1111; odd_even = 1'b0; #10;
    data = 8'b0000_0000; odd_even = 1'b0; #10;

    $finish;
end

endmodule
