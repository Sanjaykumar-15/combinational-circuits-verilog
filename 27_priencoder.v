// Designed by Sanjaykumar R

module pri_encoder(
    input [7:0] in,
    output reg [2:0] out

);
always @(*) begin
    casex(in)
        8'b00000001: out = 3'b000;
        8'b0000001x: out = 3'b001;
        8'b000001xx: out = 3'b010;
        8'b00001xxx: out = 3'b011;
        8'b0001xxxx: out = 3'b100;
        8'b001xxxxx: out = 3'b101;
        8'b01xxxxxx: out = 3'b110;
        8'b1xxxxxxx: out = 3'b111;
        default: out = 3'bxxx;
    endcase
end
endmodule

module tb_pri_ec;
    reg [7:0] in;
    wire [2:0] out;

    pri_encoder uut (
        .in(in),
        .out(out)
    );

    initial begin
    $dumpfile("pri_tb_ec.vcd");
    $dumpvars(0, tb_pri_ec);

        in = 8'b00000001; #10;
        in = 8'b00000010; #10;
        in = 8'b00000100; #10;
        in = 8'b00001000; #10;
        in = 8'b00010000; #10;
        in = 8'b00100000; #10;
        in = 8'b01000000; #10;
        in = 8'b10000000; #10;
        in = 8'b00000000; #10;

        $finish;
    end
    initial begin
        $monitor("Time: %0t, in: %b, out: %b", $time, in, out);
    end
    endmodulee
