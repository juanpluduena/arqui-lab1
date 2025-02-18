module alu #(parameter N = 64) (
    input  logic [63:0] a, b,
    input  logic [3:0] ALUControl,
    output logic [63:0] result,
    output logic        zero,
    output logic        Ne, V, C,
    output logic        write_flags
);

    logic [63:0] complemento_b;
    
    always_comb begin
        complemento_b = ~b + 1;
        casez (ALUControl)
            4'b0000: result = a & b; 
            4'b0001: result = a | b;
            4'b0010,
            4'b1010: result = a + b;
            4'b0110,
            4'b1110: result = a + complemento_b; 
            4'b0111: result = b;
            default: result = 64'b0;
        endcase
    end

    always_comb begin
        write_flags = ALUControl[3];
    end

    always_comb begin
        zero = (result == 0);
        Ne = result[63];
        
        if (ALUControl == 4'b0010 || ALUControl == 4'b1010) begin
            V = (~(a[63] ^ b[63]) && (result[63] ^ a[63]));
            C = (result < a);
        end else if (ALUControl == 4'b0110 || ALUControl == 4'b1110) begin
            V = ((a[63] ^ b[63]) && (result[63] ^ a[63]));
            C = (a >= b);
        end else begin
            V = 0;
            C = 0;
        end
    end
endmodule
