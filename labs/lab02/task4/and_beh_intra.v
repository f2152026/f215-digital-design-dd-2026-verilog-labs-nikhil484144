module and_beh_intra (
  input      a,
  input      b,
  output reg y
);
  always @(*) begin
    // Evaluates a & b immediately, waits 1 time unit, THEN assigns
    y = #3 a & b;
  end
endmodule