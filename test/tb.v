`default_nettype none
`timescale 1ns / 1ps

module tb();

  reg  [7:0] ui_in;
  reg        clk;
  reg        rst_n;
  reg        ena;
  reg  [7:0] uio_in;

  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;
  
  // initialize test object
  tt_um_perceptron dut (
    .ui_in(ui_in),
    .uo_out(uo_out),
    .uio_in(uio_in),
    .uio_out(uio_out),
    .uio_oe(uio_oe),
    .clk(clk),
    .rst_n(rst_n),
    .ena(ena)
  );
  
  initial begin

    clk    = 0;
    ena    = 1'b1;
    rst_n  = 1'b1;
    uio_in = 8'b0;

    $display("\n");

    // test case: positive sum
    ui_in = {4'sd1, 4'sd2};
    #1;
    $display("running test case: positive sum...");
    $display("x_1 = %0d, x_2 = %0d, y = %b (expected = 1)\n", $signed(ui_in[3:0]), $signed(ui_in[7:4]), uo_out[0]);
    
    // test case: zero sum
    ui_in = {4'sd2, -4'sd2};
    #1;
    $display("running test case: zero sum...");
    $display("x_2 = %0d, x_2 = %0d, y = %b (expected = 0)\n", $signed(ui_in[3:0]), $signed(ui_in[7:4]), uo_out[0]);
    
    // test case: double negative multiplication
    ui_in = {-4'sd1, -4'sd1};
    #1;
    $display("running test case: double negative multiplication...");
    $display("x_1 = %0d, x_2 = %0d, y = %b (expected = 1)\n", $signed(ui_in[3:0]), $signed(ui_in[7:4]), uo_out[0]);
    
  end

endmodule
