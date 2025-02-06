module imem #(parameter N = 32) (
	input logic [5:0] addr,
	output logic [N-1:0] q
);
	logic [N-1:0] ROM [0:63] = '{default:32'b0};
	
	initial begin
		ROM [0:8] = '{32'h8b1f03c9,
			32'h8b1f03e2,
			32'hf8000002,
			32'h8b010042,
			32'h8b080000,
			32'hcb010129,
			32'hb4000049,
			32'hb4ffff7f,
			32'hb400001f};
	end
	
	assign q = ROM[addr];
endmodule
