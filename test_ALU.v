`include "ALU_stage.v"

module test_ALU ();


reg [31:0] regdataA;
reg [31:0] regdataB;
reg [31:0] PC;
reg [31:0] immediate;
reg [2:0] itype;
reg [6:0] opcode;
reg [2:0] funct3;
reg [6:0] funct7;
reg [4:0] regdest;
reg iOrR;

wire [31:0] result;
wire [2:0] flags;
wire [2:0] funct3Out;
wire [6:0] funct7Out;
wire [6:0] opcodeOut;
wire [31:0] newPC;


ALU_stage dut 
(
    .regdataA(regdataA),
    .regdataB(regdataB),
    .PC(PC),
    .immediate(immediate),
    .itype(itype),
    .opcode(opcode),
    .funct3(funct3),
    .funct7(funct7),
    .regdest(regdest),
    .iOrR(iOrR),
    
    .result(result),
    .flags(flags),
    .funct3Out(funct3Out),
    .funct7Out(funct7Out),
    .opcodeOut(opcodeOut),
    .newPC(newPC)
);

task checkAdd
(
    input [31:0] a, b,
    input [31:0] result,
    input [2:0] flags,
    input [2:0] funct3Out,
    input [6:0] funct7Out,
    input [6:0] opcodeOut,
    input [31:0] newPC
);
    if (result != a + b) begin
        $error("Result is not equal to sum");
    end
endtask

task checkShift
(
    input [31:0] a, b,
    input [31:0] result,
    // 0: Left 1: Right
    input LorR,
    // 0: Logical 1: Arithmetic
    input LorA
);
begin
    if (LorR == 0) begin
        if (result != a << b) begin
            $error("Result is not properly left shifted");
        end
    end else begin
        if (LorA == 0) begin
            if (result != a >> b) begin
                $error("Result is not properly right shifted");
            end
        end else begin
            if (result != a >>> b) begin
                $error("Result is not properly right shifted");
            end
        end
    end

end
endtask

task init();
    begin
    regdataA <= 0;
    regdataB <= 0;
    PC <= 0;
    immediate <= 0;
    itype <= 0;
    opcode <= 0;
    funct3 <= 0;
    funct7 <= 0;
    regdest <= 0;
    iOrR <= 0;
    end
endtask

task additionReg
(
    input [31:0] a, b
);
begin
    regdataA <= a;
    regdataB <= b;
    immediate <= 100;
    iOrR <= 0;
    opcode <= 7'b0110011;
    funct3 <= 3'h0;
    funct7 <= 7'h00;
    #10;
    //$display($signed(result));
    checkAdd(a,b,result,flags,funct3Out,funct7Out,opcodeOut,newPC);
end
endtask

task additionImm
(
    input [31:0] a, b
);
begin
    regdataA <= a;
    regdataB <= 100;
    immediate <= b;
    iOrR <= 1;
    opcode <= 7'b0110011;
    funct3 <= 3'h0;
    #10;
    //$display($signed(result));
    checkAdd(a,b,result,flags,funct3Out,funct7Out,opcodeOut,newPC);
end
endtask

task shiftLeftReg
(
    input [31:0] a, b
);
begin
    regdataA <= a;
    regdataB <= b;
    immediate <= 100;
    iOrR <= 0;
    opcode <= 7'b0110011;
    funct3 <= 3'h1;
    funct7 <= 7'h0;
    #10;
    $display("%b", result);
    checkShift(a,b,result,0,0);
end
endtask

initial begin
    
    init();
    $display("Hello World");
    //add
    additionReg(5,4);
    additionReg(0,0);
    additionReg(-1,-1);
    additionReg(-1,0);
    additionReg(-1,1);
    $display();
    //addi
    additionImm(5,4);
    additionImm(0,0);
    additionImm(-1,-1);
    additionImm(-1,0);
    additionImm(-1,1);
    $display();
    //sll
    shiftLeftReg(3'b101, 4);

end

endmodule