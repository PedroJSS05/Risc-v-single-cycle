module ALU_control (
    input logic clk,
    input logic reset,
    input logic [9:0] functs,
    input logic [1:0] ALUop,
    output logic [3:0] op
);

always_comb begin
    case (ALUop)
        2'b00: op = 4'b0010;
        2'b01: op = 4'b0110;
        2'b10: begin
            case(functs)
                10'b0000000000: op = 4'b0010;
                10'b0100000000: op = 4'b0110;
                10'b0000000111: op = 4'b0000;
                10'b0000000110: op = 4'b0001;
            endcase
        end
    endcase
end
    
endmodule