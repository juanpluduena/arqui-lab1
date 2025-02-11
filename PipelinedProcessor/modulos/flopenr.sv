module flopenr #(parameter WIDTH = 1) (
    input logic clk, reset, en,
    input logic [WIDTH-1:0] d,
    output logic [WIDTH-1:0] q
);
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= '0; // Resetea a 0
        end else if (en) begin
            q <= d;  // Actualiza solo si `en` está activa
        end
    end
endmodule
