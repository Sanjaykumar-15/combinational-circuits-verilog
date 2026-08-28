// Designed by Sanjaykumar R

module parity_checker(
    input [3:0] in,
    output reg e_parity, o_parity

);
always @ (in) begin
  e_parity = (in[0] ^ in[1]) ^ (in[2] ^ in[3]);
  o_parity = ~e_parity;
end
endmodule

module tb_pc;
reg [3:0] in;
wire e_parity, o_parity;
parity_checker uut(
    .in(in),
    .e_parity(e_parity),
    .o_parity(o_parity)
);
initial begin
$dumpfile("parity_checker.vcd");
$dumpvars(0, tb_pc);
    in = 4'b0000;
    #10;
    in = 4'b0001;
    #10;
     in = 4'b0010;
    #10;
    in = 4'b0011;
    #10;
    in = 4'b0100;
    #10;
    in = 4'b0101;
    #10;
    in = 4'b0110;
    #10;
    in = 4'b0111;
    #10;
    in = 4'b1000;
    #10;
    in = 4'b1001;
    #10;
    in = 4'b1010;
    #10;
    in = 4'b1011;
    #10;
    in = 4'b1100;
    #10;
    in = 4'b1101;
    #10;
    in = 4'b1110;
    #10;
    in = 4'b1111;
    #10;
    $finish;
end
initial begin
    $monitor("Time: %0t, Input: %b, Even Parity: %b, Odd Parity: %b", $time, in, e_parity, o_parity);
end
endmodule
