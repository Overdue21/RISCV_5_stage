module ALU_control
(
    input [2:0] funct3,
    input [6:0] funct7,
    input altOP,
    output reg [3:0] aluOP
);

/*
altOP:
    1'b0 = use funct
    1'b1 = Load/Store/branch/jal/jalr/lui/auipc (add)
*/

/*
aluOP:
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
    case (funct3)
        3'h0: begin
            if (funct7 == 7'h0) begin 
                //add
                aluOP = 4'h0;
            end else if (funct7 == 7'h20) begin
                //sub
                aluOP = 4'h1;
            end
        end
        //xor
        3'h4: aluOP = 4'h2;
        //or
        3'h6: aluOP = 4'h3;
        //and
        3'h7: aluOP = 4'h4;
        //sll
        3'h1: aluOP = 4'h5;
        3'h5: begin
            if (funct7 == 7'h0) begin
                //srl
                aluOP = 4'h6;
            end else if (funct7 == 7'h20) begin
                //sra
                aluOP = 4'h7;
            end
        end
        //slt
        3'h2: aluOP = 4'h8;
        //sltu
        3'h3: aluOP = 4'h9;
    endcase

    aluOP = (altOP == 0) ? aluOP : 4'b0000;

end

endmodule


