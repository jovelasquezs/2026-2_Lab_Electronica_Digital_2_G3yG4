`timescale 1ns/1ns
`include "smoke_andor.v"

module tb_smoke_andor;

  reg a, b;
  wire y_and, y_or, y_xor;

  // Instancia del DUT (Device Under Test)
  smoke_andor dut (
    .a(a),
    .b(b),
    .y_and(y_and),
    .y_or(y_or),
    .y_xor(y_xor)
  );

  initial begin
    // Generación del archivo de ondas
    $dumpfile("smoke.vcd");
    $dumpvars(0, tb_smoke_andor);

    // Estímulos: probar las 4 combinaciones posibles
    a = 0; b = 0; #10;
    a = 0; b = 1; #10;
    a = 1; b = 0; #10;
    a = 1; b = 1; #10;

    // Fin de simulación
    $finish;
  end

endmodule
