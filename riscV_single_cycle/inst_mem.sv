module inst_mem (
    input [63:0] addr4,
    output [31:0] inst
);
    logic [31:0] memoria [255:0];

    initial begin
        $readmemh("instrucao.hex", memoria,0, 9);
    end

    assign inst = memoria[addr4[9:2]];
endmodule