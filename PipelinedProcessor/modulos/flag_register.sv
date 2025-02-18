module flag_register (
	input logic clk,
	input logic write_enable,
	input logic [3:0] flags,
	output logic [3:0] q
);

	always_ff @(posedge clk)
		if (write_enable)
			q <= flags;

endmodule
