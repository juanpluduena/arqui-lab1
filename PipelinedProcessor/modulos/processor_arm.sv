// PIPELINED PROCESSOR

module processor_arm #(parameter N = 64)
							(input logic CLOCK_50, reset,
							output logic [N-1:0] DM_writeData, DM_addr, IM_address,
							output logic DM_writeEnable, PCSrc, condBranch,
							output logic [10:0] instr,
							output logic [N-1:0] PCBranch_E,
							input	logic dump);
							
	logic [31:0] q;		
	logic [3:0] AluControl;
	logic reg2loc, regWrite, AluSrc, Branch, memtoReg, memRead, memWrite;
	logic [N-1:0] DM_readData;  //DM_addr, DM_writeData
	logic DM_readEnable; //DM_writeEnable
	
	controller 		c 			(.instr(instr), 
									.AluControl(AluControl), 
									.reg2loc(reg2loc), 
									.regWrite(regWrite), 
									.AluSrc(AluSrc), 
									.Branch(Branch),
									.memtoReg(memtoReg), 
									.memRead(memRead), 
									.memWrite(memWrite),
									.condBranch(condBranch));
														
					
	datapath #(64) dp 		(.reset(reset), 
									.clk(CLOCK_50), 
									.reg2loc(reg2loc), 
									.AluSrc(AluSrc), 
									.AluControl(AluControl), 
									.Branch(Branch), 
									.memRead(memRead),
									.memWrite(memWrite), 
									.regWrite(regWrite), 
									.memtoReg(memtoReg),
									.condBranch(condBranch),
									.IM_readData(q), 
									.DM_readData(DM_readData), 
									.IM_addr(IM_address), 
									.DM_addr(DM_addr), 
									.DM_writeData(DM_writeData), 
									.DM_writeEnable(DM_writeEnable), 
									.DM_readEnable(DM_readEnable),
									.PCSrc(PCSrc),
									.PCBranch_E(PCBranch_E));				
					
					
	imem 				instrMem (.addr(IM_address[9:2]),
									.q(q));
									
	
	dmem 				dataMem 	(.clk(CLOCK_50), 
									.memWrite(DM_writeEnable), 
									.memRead(DM_readEnable), 
									.address(DM_addr[8:3]), 
									.writeData(DM_writeData), 
									.readData(DM_readData), 
									.dump(dump)); 							
		 
							
	flopr #(11)		IF_ID_TOP(.clk(CLOCK_50),
									.reset(reset), 
									.d(q[31:21]), 
									.q(instr));
 	
endmodule
