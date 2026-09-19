// tb.v
module tb;

  // 1. Declare signals
  reg  [1:0] t_a, t_b;
  wire       t_gt, t_lt, t_eq;
  
  // Variables for the testbench logic
  reg        exp_gt, exp_lt, exp_eq; // Expected values
  integer    i;                      // Loop variable
  integer    errors = 0;             // Error counter

  // 2. Instantiate DUT
  comp2 DUT (
    .A(t_a),
    .B(t_b),
    .GT(t_gt),
    .LT(t_lt),
    .EQ(t_eq)
  );

  // Waveform dump
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  // 3. Apply stimulus and check results
  initial begin
    // Loop through all 16 combinations (0 to 15)
    for (i = 0; i < 16; i = i + 1) begin
      // Assign the top 2 bits to t_a, and bottom 2 bits to t_b
      {t_a, t_b} = i[3:0];
      
      // Calculate EXPECTED values independently (Do NOT copy DUT's logic verbatim)
      exp_gt = (t_a >  t_b);
      exp_lt = (t_a <  t_b);
      exp_eq = (t_a == t_b);
      
      #5; // Wait for the DUT to evaluate
      
      // Compare actual outputs vs expected outputs
      if ({t_gt, t_lt, t_eq} !== {exp_gt, exp_lt, exp_eq}) begin
        $display("FAIL at time %0t: A=%b B=%b  got GT=%b LT=%b EQ=%b  expected GT=%b LT=%b EQ=%b",
                 $time, t_a, t_b, t_gt, t_lt, t_eq, exp_gt, exp_lt, exp_eq);
        errors = errors + 1;
      end
    end

    // 4. Print final summary using $write and $display
    $write("Simulation complete. ");
    if (errors == 0)
      $display("SUCCESS: 16/16 passed.");
    else
      $display("FAILED: %0d errors out of 16 combinations.", errors);
      
    $finish;
  end

endmodule