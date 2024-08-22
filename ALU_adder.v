module ALU_adder
(
    input [31:0] operand1,
    input [31:0] operand2,
    output reg [31:0] out
);

always @( * ) begin
    out = operand1 + operand2;
end

endmodule