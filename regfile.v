 `include "defines.v"

module regfile
  (

   input wire 		    clk,
   input wire 		    rst,

   //Ð´¶Ë¿Ú
   input wire 		    we,
   input wire [`RegAddrBus] waddr,
   input wire [`RegBus]     wdata,

   //¶Á¶Ë¿Ú1
   input wire 		    re1,
   input wire [`RegAddrBus] raddr1,
   output reg [`RegBus]     rdata1,

   //¶Á¶Ë¿Ú2
   input wire 		    re2,
   input wire [`RegAddrBus] raddr2,
   output reg [`RegBus]     rdata2

   );

   reg [`RegBus] 	    regs[0:`RegNum-1];

   always @ (posedge clk) 
     begin
	
	if (rst == `RstDisable) 
	  if((we == `WriteEnable) && (waddr != `RegNumLog2'h0)) 
	    begin
	       regs[waddr] <= wdata;
	       //$display("Write %h to %d.",wdata,waddr);
		   //$display("REG 0 %d.", regs[0]);
		   //$display("REG 1 %d.", regs[1]);
		   //$display("REG 2 %d.", regs[2]);
		   //$display("REG 3 %d.", regs[3]);
		   //$display("REG 4 %d.", regs[4]);
		   //$display("REG 5 %d.", regs[5]);
		   //$display("\n");
		   
	    end

     end
	 
	always @ (*) begin
		if(rst == `RstEnable) rdata1 <= `ZeroWord;
		else if(raddr1 == `RegNumLog2'h0) rdata1 <= `ZeroWord;
		else if((raddr1 == waddr) && (we == `WriteEnable)&& (re1 == `ReadEnable)) rdata1 <= wdata;
		else if(re1 == `ReadEnable) rdata1 <= regs[raddr1];
		else rdata1 <= `ZeroWord;
	end
	
	always @ (*) begin
		if(rst == `RstEnable) rdata2 <= `ZeroWord;
		else if(raddr2 == `RegNumLog2'h0) rdata2 <= `ZeroWord;
		else if((raddr2 == waddr) && (we == `WriteEnable)&& (re2 == `ReadEnable)) rdata2 <= wdata;
		else if(re2 == `ReadEnable) rdata2 <= regs[raddr2];
		else rdata2 <= `ZeroWord;
	end
	
	endmodule