module signext(
	input logic [31:0] a,
	output logic [63:0] y
);
	logic [10:0] opcode;
	assign opcode = a[31:21];
	
	always_comb
		casez (opcode)
			// LDUR
			11'b111_1100_0010: y = {{55{a[20]}}, a[20:12]};
			// STUR
			11'b111_1100_0000: y = {{55{a[20]}}, a[20:12]};
			// CB
			11'b101_1010_0???: y = {{45{a[23]}}, a[23:5]}; // CBZ
			11'b010_1010_0???: y = {{45{a[23]}}, a[23:5]}; // B.cond
			// I format
			11'b100_1000_100?, // ADDI 
			11'b110_1000_100?, // SUBI
			11'b101_1000_100?, // ADDIS
			11'b111_1000_100?: y = {{52{1'b0}} , a[21:10]}; // SUBIS
			// instrucciones sin valor inmediato
			default: y = 64'b0;
		endcase
endmodule
