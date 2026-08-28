// Designed by Sanjaykumar R

module sign_magnitude_to_2s_complement(
    input      [7:0] sm_in,
    output     [7:0] twos_out
);

    wire       sign;
    wire [6:0] magnitude;

    assign sign      = sm_in[7];
    assign magnitude = sm_in[6:0];

    assign twos_out = sign ? (~{1'b0, magnitude} + 8'b1) : sm_in;

endmodule

module tb_sign_magnitude_to_2s_complement;

reg  [7:0] sm_in;
wire [7:0] twos_out;
wire signed [7:0] twos_signed;

sign_magnitude_to_2s_complement dut(
    .sm_in(sm_in),
    .twos_out(twos_out)
);

assign twos_signed = twos_out;

initial
begin

    $dumpfile("sign_magnitude_to_2s_complement.vcd");
    $dumpvars(0, tb_sign_magnitude_to_2s_complement);

    $monitor("SM_IN=%b TWOS_OUT=%b (%d)", sm_in, twos_out, twos_signed);

    sm_in = 8'b0000_0101; #10;
    sm_in = 8'b1000_0101; #10;
    sm_in = 8'b0111_1111; #10;
    sm_in = 8'b1111_1111; #10;
    sm_in = 8'b0000_0000; #10;

    $finish;
end

endmodule
