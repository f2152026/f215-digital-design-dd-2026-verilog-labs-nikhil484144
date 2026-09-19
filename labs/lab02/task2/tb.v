// tb.v
// Starter testbench template -- YOU complete this file.

module tb;

  // TODO: declare the inputs and outputs
  reg  [2:0] t_sel;   // 3 bits to cover DEPTH=8
  wire [7:0] t_dout;  // 8 bits to cover WIDTH=8
  integer i;          // Loop variable

  // TODO: instantiate DUT here
  lut #(
    .WIDTH(8),
    .DEPTH(8)
  ) DUT (
    .sel(t_sel),
    .dout(t_dout)
  );

  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    // TODO: apply different input combinations
      // Loop through all 8 addresses
    for (i = 0; i < 8; i = i + 1) begin
      t_sel = i;
      #5; // Wait 5 time units to observe the output
    end
    $finish;
  end

 // Print outputs to console
  initial begin
    $monitor($time, " | sel=%d | dout=%d", t_sel, t_dout);
  end

endmodule