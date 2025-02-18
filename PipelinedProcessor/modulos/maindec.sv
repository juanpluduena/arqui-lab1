module maindec(
	input logic [10:0] Op,
	output logic Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, condBranch,
	output logic [1:0] ALUOp
);
	always_comb begin
		case (Op)
			// LDUR
			11'b111_1100_0010: begin
				Reg2Loc = 0;
				ALUSrc = 1;
				MemtoReg = 1;
				RegWrite = 1;
				MemRead = 1;
				MemWrite = 0;
				Branch = 0;
				condBranch = 0;
				ALUOp = 2'b00;
			end
			
			// STUR
			11'b111_1100_0000: begin
				Reg2Loc = 1;
				ALUSrc = 1;
				MemtoReg = 0;
				RegWrite = 0;
				MemRead = 0;
				MemWrite = 1;
				Branch = 0;
				condBranch = 0;
				ALUOp = 2'b00;
			end
			
			// CBZ
			11'b101_1010_0???: begin
				Reg2Loc = 1;
				ALUSrc = 0;
				MemtoReg = 0;
				RegWrite = 0;
				MemRead = 0;
				MemWrite = 0;
				Branch = 1;
				condBranch = 0;
				ALUOp = 2'b01;
			end
			
			// R format
			11'b101_0101_1000, // ADDS
			11'b111_0101_1000, // SUBS
			11'b100_0101_1000, // ADD
			11'b110_0101_1000, // SUB
			11'b100_0101_0000, // AND
			11'b101_0101_0000: begin // ORR
				Reg2Loc = 0;
				ALUSrc = 0;
				MemtoReg = 0;
				RegWrite = 1;
				MemRead = 0;
				MemWrite = 0;
				Branch = 0;
				condBranch = 0;
				ALUOp = 2'b10;
			end
			
			// I format
			11'b101_1000_100?, // ADDIS
			11'b111_1000_100?, // SUBIS
			11'b100_1000_100?, // ADDI
			11'b110_1000_100?: begin // SUBI
				Reg2Loc = 0;
				ALUSrc = 1;
				MemtoReg = 0;
				RegWrite = 1;
				MemRead = 0;
				MemWrite = 0;
				Branch = 0;
				condBranch = 0;
				ALUOp = 2'b10;
			end
			
			// B.cond
			11'b010_1010_0???: begin
				Reg2Loc = 0;
				ALUSrc = 1;
				MemtoReg = 0;
				RegWrite = 0;
				MemRead = 0;
				MemWrite = 0;
				Branch = 0;
				condBranch = 1;
				ALUOp = 2'b10;
			end
			
			// opcode desconocido
			default: begin
				Reg2Loc = 0;
				ALUSrc = 0;
				MemtoReg = 0;
				RegWrite = 0;
				MemRead = 0;
				MemWrite = 0;
				Branch = 0;
				condBranch = 0;
				ALUOp = 2'b00;
			end
		endcase
	end
endmodule
			