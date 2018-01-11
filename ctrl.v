 `include "defines.v"

module ctrl
  (
   input wire 	    rst,
   input wire 	    stallreq_from_id1,
   input wire 	    stallreq_from_id2,

   output reg [5:0] stall       
   );

   always @ (*) begin
	if(rst == `RstEnable) stall <= 6'b000000;
	else if (stallreq_from_id2 == 1'b1) stall <= 6'b000111;
	else if (stallreq_from_id1 == 1'b1) stall <= 6'b000010;
	else stall <= 6'b000000;
     end // always @ (*)
   
endmodule // ctrl