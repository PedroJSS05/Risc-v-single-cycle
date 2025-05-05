module data_mem (
    input  logic        clk,
    input  logic        reset,
    input  logic [63:0] address,
    input  logic [63:0] writeData,
    input  logic        memRead,
    input  logic        memWrite,
    output logic [63:0] ReadData
);

    // Profundidade: 256 palavras de 64 bits
    logic [63:0] memoria [0:255];

    integer i;
    // Inicializa memória em zero apenas uma vez, no início da simulação
    initial begin
        for (i = 0; i < 256; i = i + 1) begin
            memoria[i] = 64'b0;
        end
    end

    // Leitura e escrita sincronizada
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            ReadData = 64'b0;
        end else begin
            // Escrita tem prioridade sobre leitura, 
            // caso memRead e memWrite estejam ambos ativos
            if (memWrite) begin
                // Usa apenas os 8 LSBs do endereço para indexar 256 posições
                memoria[address[7:0]] <= writeData;
            end
            if (memRead) begin
                ReadData = memoria[address[7:0]];
            end
        end
    end

endmodule
