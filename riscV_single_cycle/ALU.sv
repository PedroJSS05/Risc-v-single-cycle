module ALU (
    input logic [63:0] in_0,
    input logic [63:0] in_1,
    input logic [3:0] ALUop,
    output logic [63:0] out,
    output logic zero
);
always_comb begin
    case (ALUop)
        4'b0010: out = in_0 + in_1;
        4'b0110: out = in_0 - in_1;
        4'b0000: out = in_0 & in_1;
        4'b0001: out = in_0 | in_1;
        4'b0011: out = in_0 ^ in_1;
    endcase
    zero = (out == 64'b0);
end
endmodule