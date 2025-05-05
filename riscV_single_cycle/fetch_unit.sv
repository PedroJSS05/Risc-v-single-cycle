module fetch_unit(
    input clk,
    input reset,
    input logic [63:0] addrI,
    output [63:0] addrO,
    output [31:0] inst
);
logic [63:0] pcO;
inst_mem inst_mem(.addr4(pcO),
                  .inst(inst));

//wire [63:0] pcIncrementado;
//assign pcIncrementado = addrI + 4;

always_ff @(posedge clk or posedge reset) begin
    if(reset)begin
        pcO <= 0;
    end else begin
        pcO <= addrI;
    end
end

assign addrO = pcO;
endmodule