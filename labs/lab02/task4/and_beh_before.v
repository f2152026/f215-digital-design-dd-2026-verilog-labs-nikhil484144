module and_beh_before (
  input      a,
  input      b,
  output reg y
);
  always @(*) begin
    // Waits 1 time unit, THEN evaluates a & b and assigns
    #3 y = a & b;
  end
endmodule