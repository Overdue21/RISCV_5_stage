module ALU_branch_eval
(
    input [31:0] regA,
    input [31:0] regB,
    input [2:0] branchType,
    output reg taken
);

reg [2:0] flags;

always @( * ) begin
    //blt(1), bge(0)
    flags[0] = ($signed(regA) < $signed(regB)) ? 1:0;
    //bltu(1), bgeu(0)
    flags[1] = (regA < regB) ? 1:0;
    //beq(1), bne(0)
    flags[2] = (regA == regB) ? 1:0;

    taken = (branchType == flags) ? 1:0;
end

endmodule