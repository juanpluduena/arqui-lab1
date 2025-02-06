module flopr #(parameter N = 64) (
	input logic clk,
	input logic reset,
	input logic [N-1:0] d,
	output logic [N-1:0] q
);
	always_ff @(posedge clk, posedge reset)
		if (reset) q <= {N{1'b0}}; // asigna 0 a todos los bits de q
		else q <= d;
endmodule