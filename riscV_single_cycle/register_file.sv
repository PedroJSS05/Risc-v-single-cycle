module register_file (
    input clk,
    input reset,
    input [4:0] readRegister1,
    input [4:0] readRegister2,
    input [4:0] writeRegister,
    input [63:0] writeData,
    input Regwrite,
    output [63:0] readData1,
    output [63:0] readData2
);
    logic [63:0] registers [255:0];
    integer i;
    initial begin
        for(i = 0; i < 256; i = i + 1)begin
            registers[i] = 0;
        end
    end
    assign readData1 = registers[readRegister1];
    assign readData2 = registers[readRegister2];

always_ff @(posedge clk or posedge reset) begin
    if (Regwrite && writeRegister != 0)begin
        registers[writeRegister] <= writeData;
    end
end


endmodule