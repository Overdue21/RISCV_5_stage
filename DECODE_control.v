module DECODE_control
(
    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,
    output reg branchType,
    output reg auipc,
    output reg iOrR,
    output reg altOP,
    output reg aluOrPCp4,
    output reg memWE,
    output reg memRE,
    output reg regLoad,
    output reg regWE
);

endmodule