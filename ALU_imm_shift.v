module ALU_imm_shift
(
    input [31:0] imm,
    output reg [31:0] out
);

always @( * ) begin
    out = imm << 1;
end

endmodule