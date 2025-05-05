`timescale 1ns/1ps

module tb;
  logic clk;
  logic reset;

  top topinst(.clk(clk),
              .reset(reset));

  initial begin
    $dumpfile("top.vcd");
    $dumpvars(0, tb);
  end

  integer i;
  initial begin
    for (i = 0; i < 32; i = i + 1) begin
        $dumpvars(0, tb.topinst.register_file.registers[i]);
    end
  end

  always #500_000_000 clk = ~clk;

  // Termina a simulação depois de 20 ciclos (20 segundos)
initial begin
    clk = 1;
    reset = 1;
    #1_000_000_000;
    reset = 0;
end
initial begin
    #50_000_000_000;
    $finish;
end
endmodule
