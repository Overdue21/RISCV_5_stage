// If a branch/jmp is taken two instructions need to be flushed
// Zero the IF/ID and ID/EX pipeline register

// F D E |M W
//   F D |E M W
//     F |D E M W
//       |F D E M W

// Memory read after write is not an issue since writes must be
// executed prior to the subsequent read.

// The only read after write hazards can be observed by compairing
// destination regs to operands.

// PC, IF/ID, ID/EX need to be stalled (prevented from loading)
// ID/EX needs to insert a bubble when stalled (stall and NOP are both
// edge triggered, so they should be connected together for this reg)

// If rd of EX  == operand stall for 3 cycles
// If rd of MEM == operand stall for 2 cycles
// If rd of WB  == operand stall for 1 cycle
// rd is guarenteed to be zero if instruction is a store or branch

// The re-decoding of the instruction type feels far from ideal here
// I'd like to find a better way of pulling data from the middle of
// a pipeline stage.

module stall_unit
(
    input [6:0] opcode,
    //need to standardize reg nomenclature
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rdEX,
    input [4:0] rdMEM,
    input [4:0] rdWB,
    input branched,
    output reg stall,
    output wire flush
);

reg [4:0] rs1real;
reg [4:0] rs2real;

assign flush = branched; 

always @( * ) begin
    case (opcode) 
        7'b0110011: begin
            rs1real = rs1;
            rs2real = rs2;
        end
        7'b0010011: begin
            rs1real = rs1;
            rs2real = 0;
        end
        7'b0000011: begin
            rs1real = rs1;
            rs2real = 0;
        end
        7'b0100011: begin
            rs1real = rs1;
            rs2real = rs2;
        end
        7'b1100011: begin
            rs1real = rs1;
            rs2real = rs2;
        end
        7'b1101111: begin
            rs1real = 0;
            rs2real = 0;
        end
        7'b1100111: begin
            rs1real = rs1;
            rs2real = 0;
        end
        7'b0110111: begin
            rs1real = 0;
            rs2real = 0;
        end
        7'b0010111: begin
            rs1real = 0;
            rs2real = 0;
        end
    endcase
end

always @( * ) begin
    if ((rs1 == rdEX || rs2 == rdEX) && rdEX != 0) begin
        stall = 1;
    end
    if ((rs1 == rdMEM || rs2 == rdMEM) && rdMEM != 0) begin
        stall = 1;
    end
    if ((rs1 == rdWB || rs2 == rdWB) && rdWB != 0) begin
        stall = 1;
    end
end

endmodule