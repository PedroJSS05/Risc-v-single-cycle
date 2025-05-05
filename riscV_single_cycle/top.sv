`include "ALU_control.sv"
`include "ALU.sv"
`include "control_unit.sv"
`include "data_mem.sv"
`include "fetch_unit.sv"
`include "imm_gen.sv"
`include "inst_mem.sv"
`include "register_file.sv"

module top(
    input  logic        clk,
    input  logic        reset
);

  // fetch
  wire [63:0] addrI, addrO, addr4;
  wire [31:0] inst;

  // controle
  wire        branch, memRead, memtoReg, ALUsrc, memWrite, regWrite;
  wire  [1:0] ALUop;
  wire  [3:0] op;  

  // register file
  wire [63:0] writeData, readData1, readData2;

  // immediate generator
  wire [63:0] sd_64, ld_64, branch_64, imediate;

  // ALU
  wire [63:0] ALUin_2, ALUresult;
  wire        zero;

  // data memory
  wire [63:0] readData;

  // shift e salto
  wire [63:0] shift_left;

  // fetch unit
  fetch_unit fetch(
    .clk   (clk),
    .reset (reset),
    .addrI (addrI),
    .addrO (addrO),
    .inst  (inst)
  );

  control_unit control(
    .clk     (clk),
    .reset   (reset),
    .inst    (inst[6:0]),
    .branch  (branch),
    .memRead (memRead),
    .memtoReg(memtoReg),
    .ALUsrc  (ALUsrc),
    .memWrite(memWrite),
    .regWrite(regWrite),
    .ALUop   (ALUop)
  );

  register_file register_file(
    .clk           (clk),
    .reset         (reset),
    .readRegister1 (inst[19:15]),
    .readRegister2 (inst[24:20]),
    .writeRegister (inst[11:7]),
    .writeData     (writeData),
    .Regwrite      (regWrite),
    .readData1     (readData1),
    .readData2     (readData2)
  );

  ALU_control alu_ctrl(
    .clk    (clk),
    .reset  (reset),
    .functs ({inst[31:25], inst[14:12]}),
    .ALUop  (ALUop),
    .op     (op)
  );

  imm_gen imm_gen(
    .inst       (inst),
    .LDout      (ld_64),
    .SDout      (sd_64),
    .branchout  (branch_64)
  );

  // seleciona imediato
  assign imediate = inst[5] ? sd_64 : ld_64;
  assign ALUin_2  = ALUsrc ? imediate : readData2;

  ALU alu(
    .in_0   (readData1),
    .in_1   (ALUin_2),
    .ALUop  (op),         // ou ALUop, depende do seu módulo
    .out    (ALUresult),
    .zero   (zero)
  );

  data_mem data_mem(
    .clk       (clk),
    .reset     (reset),
    .address   (ALUresult),
    .writeData (readData2),
    .memRead   (memRead),
    .memWrite  (memWrite),
    .ReadData  (readData)
  );

  assign writeData = memtoReg ? readData : ALUresult;

  // shift e soma para branch
  assign shift_left = branch_64 << 1;
  assign addr4      = addrO + 64'd4;
  assign addrI      = (branch & zero) ? (addrO + shift_left) : addr4;

endmodule
