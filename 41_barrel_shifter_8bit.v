// Designed by Sanjaykumar R

module barrel_shifter_8bit(
    input      [7:0] din,
    input      [2:0] shift_amt,
    input            dir,       // 0 = left, 1 = right
    input            mode,      // 0 = logical shift, 1 = rotate
    output     [7:0] dout
);

    wire [7:0] stage0, stage1, stage2;

    assign stage0 = shift_amt[0] ?
                        (dir ? (mode ? {din[0], din[7:1]}   : {1'b0, din[7:1]}) :
                               (mode ? {din[6:0], din[7]}   : {din[6:0], 1'b0})) :
                        din;

    assign stage1 = shift_amt[1] ?
                        (dir ? (mode ? {stage0[1:0], stage0[7:2]} : {2'b0, stage0[7:2]}) :
                               (mode ? {stage0[5:0], stage0[7:6]} : {stage0[5:0], 2'b0})) :
                        stage0;

    assign stage2 = shift_amt[2] ?
                        (dir ? (mode ? {stage1[3:0], stage1[7:4]} : {4'b0, stage1[7:4]}) :
                               (mode ? {stage1[3:0], stage1[7:4]} : {stage1[3:0], 4'b0})) :
                        stage1;

    assign dout = stage2;

endmodule

module tb_barrel_shifter_8bit;

reg  [7:0] din;
reg  [2:0] shift_amt;
reg        dir, mode;
wire [7:0] dout;

barrel_shifter_8bit dut(
    .din(din),
    .shift_amt(shift_amt),
    .dir(dir),
    .mode(mode),
    .dout(dout)
);

initial
begin

    $dumpfile("barrel_shifter_8bit.vcd");
    $dumpvars(0, tb_barrel_shifter_8bit);

    $monitor("DIN=%b SHIFT=%d DIR=%b MODE=%b DOUT=%b", din, shift_amt, dir, mode, dout);

    din = 8'b0000_1111;

    shift_amt=3; dir=0; mode=0; #10;  // logical left 3
    shift_amt=3; dir=1; mode=0; #10;  // logical right 3
    shift_amt=2; dir=0; mode=1; #10;  // rotate left 2
    shift_amt=2; dir=1; mode=1; #10;  // rotate right 2
    shift_amt=0; dir=0; mode=0; #10;  // no shift

    $finish;
end

endmodule
