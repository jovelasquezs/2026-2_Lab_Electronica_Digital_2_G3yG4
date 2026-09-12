`timescale 1ns / 1ps
module Semaforo(
    input clk,
    output reg[2:0] led
    );
    
integer counter=0;

always @(posedge  clk) //Contador comun y corriente

    begin
    if (counter>=320000000)
        counter <= 0;
    else
        counter <= counter + 1;   
    end

always @(posedge  clk)
    
    begin
    if (counter == 0)
        led <= 3'b001;//Rojo
    else if (counter == 80000000)
        led <= 3'b011;//Amarillo
    else if (counter == 160000000)
        led <= 3'b010;//Verde
    else if (counter == 240000000)
        led <= 3'b011;//Amarillo
    end
    
endmodule
