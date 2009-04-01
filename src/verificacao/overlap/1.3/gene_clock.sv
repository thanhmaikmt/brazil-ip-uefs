

module gene_clock(output logic reset, clk);

  initial clk <= 0;
  always #5 clk <= !clk; //OBS no sinal de negacao

  initial begin
    reset <= 1;
    #12;
    reset <= 0;
  end

endmodule

