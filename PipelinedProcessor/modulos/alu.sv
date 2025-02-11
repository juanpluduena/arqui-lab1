module alu (
	input logic [63:0] a, b,
	input logic [3:0] ALUControl,
	output logic [63:0] result,
	output logic zero,
	output logic Z, N, V, C,
	output logic write_flags);
	
	logic [63:0] complemento_b;

	always_comb begin
		complemento_b = ~b + 1;
		casez (ALUControl)
			4'b0000: result = a & b;
			4'b0001: result = a | b;
			4'b0010, 4'b1010: result = a + b;
			4'b0110, 4'b1110: result = a + complemento_b;
			4'b0111: result = b;
			default: result = 0;
		endcase
		
		write_flags = ALUControl[3];
		zero = &(~result);
		Z = zero;
		N = result[63];
		V = (~(ALUControl[2] ^ a[63] ^ b[63]) && (result[63] ^ a[63]) && ALUControl[1]);
		C = ((a[63] == b[63]) && (result[63] != a[63]) && ALUControl[1]); 

	end
endmodule