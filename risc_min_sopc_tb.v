 `include "defines.v"
 `include "risc_min_sopc.v"
 `timescale 1ns/1ps
 
module risc_min_sopc_tb();

   reg CLOCK_50;
   reg rst;

   integer i;
   
   initial
     begin
	CLOCK_50 = 1'b0;
	forever #10 CLOCK_50 = ~CLOCK_50;
     end

   initial
     begin
	rst = `RstEnable;
	#19 rst = `RstDisable;
	#1600 $finish;
     end

   risc_min_sopc risc_min_sopc0
     (
      .clk(CLOCK_50),
      .rst(rst)
      );
   
endmodule // risc_min_sopc_tb
