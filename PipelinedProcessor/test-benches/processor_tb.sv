// Testbench ProcessorPatterson
// Top-level Entity: processor_arm

module processor_tb();
	localparam  N = 64;
	logic        	CLOCK_50, reset;
	logic        	DM_writeEnable, PCSrc, condBranch;
	logic [N-1:0] 	DM_writeData, DM_addr, IM_address;
	logic 			dump;
	logic [10:0] instr;
	logic [N-1:0] PCBranch_E;
  
  // instantiate device under test
  processor_arm  dut (CLOCK_50, reset, DM_writeData, DM_addr, IM_address, DM_writeEnable, PCSrc, condBranch, instr, PCBranch_E, dump);
    
  // generate clock
  always     // no sensitivity list, so it always executes
    begin
      #5 CLOCK_50 = ~CLOCK_50; 
    end
	 
	 
  initial
    begin
      CLOCK_50 = 0; reset = 1; dump = 0;
      #20 reset = 0; 
      #1600 dump = 1; 
	   #20 $stop;
	end 
endmodule

