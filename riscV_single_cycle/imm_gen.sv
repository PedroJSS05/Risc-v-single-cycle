module imm_gen (
    input [31:0] inst,
    output [63:0] LDout,
                  SDout,
                  branchout
);

wire [12:0] imm_b13 = { inst[31],
                        inst[7],
                        inst[30:25],
                        inst[11:8],
                        1'b0 };

assign LDout = {{52{inst[31]}}, inst[31:20]};
assign SDout = {{52{inst[31]}}, inst[31:25], inst[11:7]};
assign branchout = {{51{imm_b13[12]}}, imm_b13};
    
endmodule