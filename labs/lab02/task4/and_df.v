module and_df (
  input  a,
  input  b,
  output y
);
  // Continuous assignment with delay
  assign #3 y = a & b;
endmodule