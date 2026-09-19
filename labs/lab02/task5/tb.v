// tb.v
module tb;

  // 1. Declare signals
  reg  [3:0] t_a, t_b;
  reg        t_op;
  wire [3:0] t_result;
  
  // Variables for checking
  reg  [3:0] exp_result;
  integer    i;
  integer    errors = 0;

  // 2. Instantiate the ALU
  alu DUT (
    .a(t_a),
    .b(t_b),
    .op(t_op),
    .result(t_result)
  );

  // Waveform dump
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  // 3. Apply all 512 stimulus combinations and check
  initial begin
    for (i = 0; i < 512; i = i + 1) begin
      // Assign the 9 bits of 'i' to our inputs
      {t_op, t_a, t_b} = i[8:0];
      
      // Compute the expected result independently
      if (t_op == 1'b0)
        exp_result = t_a + t_b; // Add
      else
        exp_result = t_a - t_b; // Subtract
      
      #5; // Wait for ALU to process
      
      // Check if actual result matches expected result
      if (t_result !== exp_result) begin
        $display("FAIL: op=%b a=%d b=%d | got=%d expected=%d", 
                 t_op, t_a, t_b, t_result, exp_result);
        errors = errors + 1;
      end
    end

    // 4. Print Summary
    $write("Simulation complete. ");
    if (errors == 0)
      $display("SUCCESS: All 512 combinations passed.");
    else
      $display("FAILED: %0d errors out of 512 combinations.", errors);
      
    $finish;
  end

endmodule