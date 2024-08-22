`include "ALU_alu.v"
`include "ALU_control.v"
`include "mux_3_1.v"
`include "mux_2_1.v"
`include "ALU_adder.v"
`include "ALU_imm_shift.v"

module ALU_stage
(
    //These will be replaced with a single large input from
    input [31:0] regdataA,
    input [31:0] regdataB,
    input [31:0] PC,
    input [31:0] immediate,
    input [2:0] itype, 
    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,
    input [4:0] regdest,
    input iOrR,
    output [31:0] result,
    output [2:0] flags,
    output [2:0] funct3Out,
    output [6:0] funct7Out,
    output [6:0] opcodeOut,
    output [31:0] newPC
);

/*
    iOrR generated by control unit and stored in the pipereg
    0: reg2
    1: immediate  
*/

// Wire from operand2 select to alu
wire [31:0] operand2;

//Wire from control to alu (aluOP)
wire [3:0] aluOP;

//Wire from immediate shifter to adder (jal/branch)
wire [31:0] immToAdd;

ALU_imm_shift immShifter
(
    .imm(immediate),
    .out(immToAdd)
);

ALU_adder jalAdder
(
    .operand1(immToAdd),
    .operand2(PC),
    .out(newPC)
);

mux_2_1 operand2Sel 
(
    .in1(regdataB),
    .in2(immediate),
    .select(iOrR),
    .out(operand2)
);

ALU_control control
(
    .funct3(funct3),
    .funct7(funct7),
    .aluOP(aluOP)
);

ALU_alu alu
(
    .aluOP(aluOP),
    .operand1(regdataA),
    .operand2(operand2),
    .result(result),
    .flags(flags)
);

endmodule