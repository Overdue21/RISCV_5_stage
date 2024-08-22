module ALU_alu
#(
    parameter   OPERAND_WIDTH = 32
)
(
    input [3:0] aluOP,
    input [OPERAND_WIDTH-1:0] operand1,
    input [OPERAND_WIDTH-1:0] operand2,
    output reg [OPERAND_WIDTH-1:0] result,
    output reg [2:0] flags
);

/*
    4'b0000 = add
    4'b0001 = sub
    4'b0010 = xor
    4'b0011 = or
    4'b0100 = and
    4'b0101 = sll
    4'b0110 = srl
    4'b0111 = sra
    4'b1000 = slt
    4'b1001 = sltu
*/
always @( * ) begin
    //blt(1), bge(0)
    flags[0] = ($signed(operand1) < $signed(operand2)) ? 1:0;
    //bltu(1), bgeu(0)
    flags[1] = (operand1 < operand2) ? 1:0;
    //beq(1), bne(0)
    flags[2] = (operand1 == operand2) ? 1:0;

    case (aluOP)
        4'b0000: result = operand1 + operand2;
        4'b0001: result = operand1 - operand2;
        4'b0010: result = operand1 ^ operand2;
        4'b0011: result = operand1 | operand2;
        4'b0100: result = operand1 & operand2;
        4'b0101: result = operand1 << operand2;
        4'b0110: result = operand1 >> operand2;
        4'b0111: result = operand1 >>> operand2;
        
        4'b1000: result = ($signed(operand1) < $signed(operand2))?1:0;
        4'b1001: result = (operand1 < operand2) ? 1:0;
    endcase
end

endmodule