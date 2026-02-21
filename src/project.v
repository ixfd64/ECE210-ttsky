`default_nettype none

module tt_um_perceptron (
  input  [7:0] ui_in,
  input  [7:0] uio_in,
  input        clk,
  input        rst_n,
  input        ena,

  output [7:0] uo_out,
  output [7:0] uio_out,
  output [7:0] uio_oe
);

  assign uio_out = 8'b0;
  assign uio_oe  = 8'b0;

  // read inputs
  wire signed [3:0] x1;
  wire signed [3:0] x2;
  assign x1 = ui_in[3:0];
  assign x2 = ui_in[7:4];

  // assign weights and bias
  localparam signed [3:0] w1 = 4'sd2;
  localparam signed [3:0] w2 = -4'sd2;
  localparam signed [8:0] b  = 9'sd1;
  
  // use multiply-accumulate operations to compute weighted sum
  wire signed [7:0] mac1 = w1 * x1;
  wire signed [7:0] mac2 = w2 * x2;
  wire signed [8:0] sum  = mac1 + mac2 + b;

  // activation function to determine predicted class
  wire y = (sum >= 0) ? 1'b1 : 1'b0;

  // return outputs
  assign uo_out = {7'b0, y};

  // avoid warnings about unused wires
  wire _unused = &{uio_in, clk, rst_n, ena, 1'b0};

endmodule
