module fetch #(parameter N = 64) (
	input logic PCSrc_F, clk, reset,
	input logic [N-1:0] PCBranch_F,
	output logic [N-1:0] imem_addr_F
);
	logic [N-1:0] mux_result, adder_result, flop_result;
	
	mux2 mux_inst (
		.d0(adder_result),
		.d1(PCBranch_F),
		.s(PCSrc_F),
		.y(mux_result)
	);
	
	flopr flopr_inst (
	  .clk(clk),
	  .reset(reset),
	  .d(mux_result),
	  .q(imem_addr_F)
    );
	 
	 adder adder_inst (
		.a(imem_addr_F),
		.b(64'h4),
		.y(adder_result)
	 );
	 
	 //assign imem_addr_F = flop_result;
endmodule
