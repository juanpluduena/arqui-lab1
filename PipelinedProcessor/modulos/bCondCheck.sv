module bCondCheck (
    input logic z, n, v, c, condBranch,
    input logic [4:0] qIF_ID,
    output logic cBranch
);
    always_comb begin
        if (condBranch) begin
            case (qIF_ID)
                5'b00000: cBranch = (z == 1);                // EQ
                5'b00001: cBranch = (z == 0);                // NE
                5'b00010: cBranch = (c == 1);                // HS
                5'b00011: cBranch = (c == 0);                // LO
                5'b00100: cBranch = (n == 1);                // MI
                5'b00101: cBranch = (n == 0);                // PL
                5'b00110: cBranch = (v == 1);                // VS
                5'b00111: cBranch = (v == 0);                // VC
                5'b01000: cBranch = (z == 0) && (c == 1);    // HI
                5'b01001: cBranch = (z == 1) || (c == 0);    // LS
                5'b01010: cBranch = (n == v);                // GE
                5'b01011: cBranch = (n != v);                // LT
                5'b01100: cBranch = (z == 0) && (n == v);    // GT
                5'b01101: cBranch = (z == 1) || (n != v);    // LE
                default: cBranch = 0;
            endcase
        end else begin
            cBranch = 0;
        end
    end
endmodule
