module bCondCheck (
    input logic [3:0] sel,
    input logic [3:0] flags,
    output logic cBranch
);

    always_comb begin
        case (sel)
            4'b0000: cBranch = (flags[3] == 1);                				// EQ
            4'b0001: cBranch = (flags[3] == 0);                				// NE
            4'b0010: cBranch = (flags[1] == 1);                				// HS
            4'b0011: cBranch = (flags[1] == 0);                				// LO
            4'b0100: cBranch = (flags[2] == 1);                				// MI
            4'b0101: cBranch = (flags[2] == 0);                				// PL
            4'b0110: cBranch = (flags[0] == 1);                				// VS
            4'b0111: cBranch = (flags[0] == 0);                				// VC
            4'b1000: cBranch = (flags[3] == 0) && (flags[1] == 1);    		// HI
            4'b1001: cBranch = (flags[3] == 1) || (flags[1] == 0);    		// LS
            4'b1010: cBranch = (flags[2] == flags[0]);                		// GE
            4'b1011: cBranch = (flags[2] != flags[0]);                		// LT
            4'b1100: cBranch = (flags[3] == 0) && (flags[2] == flags[0]); 	// GT
            4'b1101: cBranch = (flags[3] == 1) || (flags[2] != flags[0]); 	// LE
            default: cBranch = 0;
        endcase
    end
endmodule
