`timescale 1s / 1ms
`include "FETCH_stage.v"

module test_FETCH ();

reg branchSel;
reg clk;
reg stall;
reg reset;
reg [31:0] branchTarget;

wire [31:0] PC;
/*
always @( * ) begin
    clk = ~clk;
    #10;
end
*/
FETCH_stage dut
(
    .branchSel(branchSel),
    .clk(clk),
    .stall(stall),
    .reset(reset),
    .branchTarget(branchTarget),

    .PC(PC)
);

task init();
begin
    branchSel <= 0; 
    stall <= 0;
    reset <= 0;
    #10;
    reset <= 1;
    #10;
    reset <= 0;
    branchTarget <= {1'b1, 31'b0};
end
endtask
integer i = 0;
initial begin
    init();
    while(i < 20) begin
        if (i % 5 == 0) begin
            branchSel <= 1;
        end
        if ((i % 10)-1 == 0) begin
            reset <= 1;
            #10;
            reset <= 0;
        end
        clk <= 1;
        #10;
        clk <= 0;
        #10;
        i += 1;
        branchSel <= 0;
        stall <= 0;
        $display("%h",PC);
    end
end

endmodule