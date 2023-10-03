module matvec_mul_tb;
 logic signed [2:0][17:0] wire_y;
  // Clock signal
  logic clk = 0;
  always #5 clk = ~clk;

  // Control enable signal
  logic cen = 1'b1;

  // Instantiate the matvec_mul module
  matvec_mul #(
    .R(3), // Set to 3 rows
    .C(3), // Set to 3 columns
    .W_X(8), // Set to 8-bit input width
    .W_K(8) // Set to 8-bit weight width
  ) dut (
    .clk(clk),
    .cen(cen),
    .k({{8'd1, 8'd2, 8'd3}, {8'd4, 8'd5, 8'd6}, {8'd7, 8'd8, 8'd9}}), // Define a 3x3 matrix for k
    .x({8'd1, 8'd2, 8'd3}), // Define a 3-element vector for x
    .y()
  );

  // Expected output for the given input
  logic signed [2:0][17:0] expected_y = {{18'h0, 18'h0, 18'h0}, {18'h0, 18'h0, 18'h0}, {18'h0, 18'h0, 18'h0}};

  // Wait for some time to allow the calculation to complete
  initial begin
    #100;

    // Read the result y from the module
   
   
    // Compare y with the expected result
    if (wire_y == expected_y) begin
      $display("Test PASSED");
    end else begin
      $display("Test FAILED");
    end

    // Terminate the simulation
    $finish;
  end

endmodule
