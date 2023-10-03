
module matvec_mul_tb;
  timeunit 1ns/1ps;

  localparam R=2, C=5, W_X=3, W_K=4, // R: # of rows, C: # of columns, W_X: bitwidth of x, W_K: bitwidth of k
  W_Y = W_X + W_K + $clog2(C),       // bitwidth of y = W_X + W_K + log2(C)
  LATENCY = $clog2(C) + 1,           // latency of the module = log2(C) + 1
  NUM_DATA = 100, CLK_PERIOD = 10;  // number of data to be tested, clock period



  typedef logic signed [C-1:0][W_K -1:0] kr_t;     // kr_t: row of k
  kr_t k_row;                                     // k_row: row of k
  logic clk=0, cen=1;                             // clk: clock, cen: enable
  logic signed [R-1:0][C-1:0][W_K -1:0] k;        // k: weight matrix R rows and C columns with W_K bitwidth
  logic signed [C-1:0][W_X -1:0] x;               // x: input vector with C columns and W_X bitwidth
  logic signed [R-1:0][W_Y -1:0] y, y_exp;          // y: output vector with R rows and W_Y bitwidth
  matvec_mul #(.R(R), .C(C), .W_X(W_X), .W_K(W_K)) dut (.*);    // dut: dut instance
  initial forever #(CLK_PERIOD/2) clk <= ~clk;                  

  initial begin
  $dumpfile("dump.vcd"); $dumpvars(0, dut);
  repeat (NUM_DATA) begin
      @(posedge clk); #1
        for(int r=0; r<R; r++) begin
          for(int c=0; c<C; c++) begin
          x [c] = $urandom_range(0, 2**W_X-1);
          k_row[c] = $urandom_range(0, 2**W_K-1);
          end
        k[r] = k_row;
        end
      // Wait for output
      repeat (LATENCY) @(posedge clk); #1
        y_exp = 0;
      foreach (y[r]) begin
        k_row = k[r];
        foreach (x[c])
          y_exp[r] = $signed(y_exp[r]) + $signed(x[c]) * $signed(k_row[c]);
      end
      // Check
      assert (y == y_exp)
      $display("Output matched: %d", y);
      else
      $error("Output doesnt match. y:%d != y_exp:%d", y, y_exp);
  end
  $finish;
end
endmodule

