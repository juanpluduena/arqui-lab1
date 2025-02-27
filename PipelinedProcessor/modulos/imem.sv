module imem #(parameter N = 32) (
	input logic [7:0] addr,
	output logic [N-1:0] q
);
	logic [N-1:0] ROM [0:159];
	
	initial begin
		ROM = '{default:0};
		$readmemh("progs/main.txt", ROM);
	end
	
	assign q = ROM[addr];
endmodule
