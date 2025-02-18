// Etapa: MEMORY
module memory (
    input logic clk, Branch_M, write_flags_M, condBranch,
    input logic [3:0] CPSR_flags,
    input logic [3:0] cond_code,                    
    output logic PCSrc_M
);

    logic [3:0] flags_out;
    logic branch_condition_met;
    logic unconditional_branch;

    flag_register CPSR_FLAGS (
        .clk(clk),
        .write_enable(write_flags_M),
        .flags(CPSR_flags),
        .q(flags_out)
    );

    bCondCheck BCOND (
        .sel(cond_code),
        .flags(flags_out),
        .cBranch(branch_condition_met)
    );

    mux2 MUX_MEM (
        .d0(unconditional_branch),
        .d1(branch_condition_met),
        .s(condBranch),
        .y(PCSrc_M)
    );

    assign unconditional_branch = Branch_M & CPSR_flags[3];

endmodule