module DECODE_imm_extract
(
    input [31:0] instruct,
    output reg [31:0] imm
);

wire [6:0] opcode = instruct[6:0];
wire [11:0] imm_I = instruct[31:20];
wire [11:0] imm_S = {instruct[31:25],instruct[11:7]};
wire [12:0] imm_B = {instruct[31],instruct[7],instruct[30:25],instruct[11:8],1'b0};
wire [31:0] imm_U = {instruct[31:12],{12{1'b0}}};
wire [20:0] imm_J = {instruct[21],instruct[19:12],instruct[20],instruct[30:21],1'b0};


always @( * ) begin
    imm = 32'b0;
    // Possibly separate into imm-type then extend
    case (opcode) 
        7'b0010011: imm = {{20{imm_I[11]}},imm_I};
        7'b0000011: imm = {{20{imm_I[11]}},imm_I};
        7'b0100011: imm = {{20{imm_S[11]}},imm_S};
        7'b1100011: imm = {{19{imm_B[12]}},imm_B};
        7'b1101111: imm = {{11{imm_J[20]}},imm_J};
        7'b1100111: imm = {{20{imm_I[11]}},imm_I};
        7'b0110111: imm = imm_U;
        7'b0010111: imm = imm_U;
        // Haven't implemented ecall/ebreak
    endcase
end

endmodule