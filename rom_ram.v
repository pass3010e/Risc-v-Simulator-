
 `include "defines.v"
 
module rom_ram(
   input wire 		     clk,
   input wire 		     rom_ce,
   input wire 		     mem_ce,
   input wire [`InstAddrBus] pc_addr,
   output reg [`InstBus]     inst,
   
   // About memory

   input wire 		     we,
   input wire [`DataAddrBus] addr,
   input wire [3:0] 	     sel,
   input wire [`DataBus]     data_i,
   output reg [`DataBus]     data_o
   );
   
   reg[`InstBus]  Mem[0:`MemNumber];
   initial $readmemh("instr_even.data",Mem);
   always @ (*)
     begin
	if (rom_ce == `ChipDisable) inst <= `ZeroWord;
	else
	  begin
	     inst <= {Mem[pc_addr>>2][7:0],Mem[pc_addr>>2][15:8], Mem[pc_addr>>2][23:16],Mem[pc_addr>>2][31:24]};
	  end
     end

   // Store
   always @ (posedge clk) 
     begin
	if (mem_ce == `ChipDisable) data_o <= `ZeroWord;
	else if(we == `WriteEnable)
	  begin     
	     if (sel[0] == 1'b1) 
	       begin 
		  Mem[addr>>2][31:24] <= data_i[7:0];
		  if ((addr>>2) == (32'h00000104>>2))
		    $display("%h",data_i[31:0]);
	       end
	     if (sel[1] == 1'b1) 
	       begin
		   Mem[addr>>2][23:16] <= data_i[15:8];
	       end
	     if (sel[2] == 1'b1) 
	       begin
		  Mem[addr>>2][15:8] <= data_i[23:16];
	       end
	     if (sel[3] == 1'b1) 
	       begin
		  Mem[addr>>2][7:0] <= data_i[31:24];
	       end
	  end	
     end
   // Load
   always @ (*) 
     begin
	if (mem_ce == `ChipDisable) data_o <= `ZeroWord;
	else if(we == `WriteDisable)
	  begin
	     data_o <= {Mem[addr>>2][7:0],Mem[addr>>2][15:8],Mem[addr>>2][23:16],Mem[addr>>2][31:24]};

	  end
	else data_o <= `ZeroWord;
    end		
	
endmodule // inst_rom


