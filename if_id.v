 `include "defines.v"
 
module if_id
  (
   input wire 		     clk,
   input wire 		     rst,

   input wire [5:0] 	     stall,

   input wire [`InstAddrBus] if_pc,
   input wire [`InstBus]     if_inst,
   output reg [`InstAddrBus] id_pc,
   output reg [`InstBus]     id_inst
   );

   always @ (posedge clk)
     begin
	
	if (rst == `RstEnable) 
	  begin
	     id_pc <= `ZeroWord;
	     id_inst <= `ZeroWord;
	  end
	else if (stall[1] == 1'b1&&stall[2] == 1'b0)
	  begin
	     id_pc <= `ZeroWord;
	     id_inst <= `ZeroWord;
	  end
	else if (stall[1] == 1'b0)
	  begin
	     id_pc <= if_pc;
	     id_inst <= if_inst;
		 //$display("id_inst %d.",id_inst[31:0]);
	  end
	
     end // always @ (posedge clk)

endmodule // if_id
