`include "mux_2_1.v"
`include "ALU_adder.v"
`include "FETCH_PC.v"

module FETCH_stage
(
    input branchSel,
    input clk, 
    input stall,
    input reset,
    input [31:0] branchTarget,
    output [31:0] PC
    //output [31:0] memAdr
);

// Wire from mux to PC
wire [31:0] PCin;

// Wire from PC to adder and instruction mem
wire [31:0] PCout;
assign PC = PCout;

// Add by four wire
wire [31:0] four = 32'd4;

// Wire from adder to mux
wire [31:0] PCp4;

mux_2_1 inputSel
(
    .in1(PCp4),
    .in2(branchTarget),
    .select(branchSel),
    .out(PCin)
);

FETCH_PC programCounter
(
    .address(PCin),
    .enable(stall),
    .reset(reset),
    .clk(clk),
    .out(PCout)
);

ALU_adder adder
(
    .operand1(four),
    .operand2(PCout),
    .out(PCp4)
);

endmodule