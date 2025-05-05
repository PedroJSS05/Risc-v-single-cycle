module control_unit (
    input logic clk,
    input logic reset,
    input logic [6:0] inst,
    output logic branch,
    output logic memRead,
    output logic memtoReg,
    output logic ALUsrc,
    output logic memWrite,
    output logic regWrite,
    output logic [1:0]ALUop
);

always_comb begin
    case (inst)
        // R-format
        7'b0110011: begin
            ALUsrc = 0;
            memtoReg = 0;
            regWrite = 1;
            memRead = 0;
            memWrite = 0;
            branch = 0;
            ALUop = 2'b10;
        end
        // LD
        7'b0000011: begin
            ALUsrc = 1;
            memtoReg = 1;
            regWrite = 1;
            memRead = 1;
            memWrite = 0;
            branch = 0;
            ALUop = 2'b00;
        end
        // SD
        7'b0100011: begin
            ALUsrc = 1;
            memtoReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite = 1;
            branch = 0;
            ALUop = 2'b00;
        end
        // BEQ
        7'b1100011: begin
            ALUsrc = 0;
            memtoReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite = 0;
            branch = 1;
            ALUop = 2'b01;
        end
        7'b0010011:begin
            ALUsrc = 1;
            memtoReg = 0;
            regWrite = 1;
            memRead = 0;
            memWrite = 0;
            branch = 0;
            ALUop = 2'b10;
        end
        default: begin
            ALUsrc = 0;
            memtoReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite = 0;
            branch = 0;
            ALUop = 0;
        end
    endcase
end
    
endmodule