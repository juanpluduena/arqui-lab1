// ALU CONTROL DECODER

module aludec (input  logic [10:0] funct,  
					input  logic [1:0]  aluop,  
					output logic [3:0] alucontrol);  				
						
	always_comb
		if (aluop == 2'b00) alucontrol = 4'b0010; // LDUR or STUR		
		else if (aluop == 2'b01) alucontrol = 4'b0111; // CBZ
		else if((aluop == 2'b10) & (funct == 11'b100_0101_1000)) alucontrol = 4'b0010; // ADD
		else if((aluop == 2'b10) & (funct == 11'b110_0101_1000)) alucontrol = 4'b0110; // SUB
		else if((aluop == 2'b10) & (funct == 11'b100_0101_0000)) alucontrol = 4'b0000; // AND
		else if((aluop == 2'b10) & (funct == 11'b101_0101_0000)) alucontrol = 4'b0001; // OR    
		else if((aluop == 2'b10) & (funct[10:1] == 10'b10_0100_0100)) alucontrol = 4'b0010; // ADDI
		else if((aluop == 2'b10) & (funct[10:1] == 10'b11_0100_0100)) alucontrol = 4'b0110; // SUBI
		else if((aluop == 2'b10) & (funct == 11'b101_0101_1000)) alucontrol = 4'b1010; // ADDS
		else if((aluop == 2'b10) & (funct == 11'b111_0101_1000)) alucontrol = 4'b1110; // SUBS
		else if((aluop == 2'b10) & (funct[10:1] == 10'b10_1100_0100)) alucontrol = 4'b1010; // ADDIS
		else if((aluop == 2'b10) & (funct[10:1] == 10'b11_1100_0100)) alucontrol = 4'b1110; // SUBIS
		else alucontrol = 4'b0000;
endmodule
