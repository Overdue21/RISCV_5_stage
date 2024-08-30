module reg_file
#(
    parameter DATA_WIDTH = 32,
    parameter ADR_WIDTH = 5
)
(
    input writeEnable,
    input clk,
    input [ADR_WIDTH-1:0] readAdrA,
    input [ADR_WIDTH-1:0] readAdrB,
    input [ADR_WIDTH-1:0] writeAdr,
    input [DATA_WIDTH-1:0] writeData,
    output wire [DATA_WIDTH-1:0] readDataA,
    output wire [DATA_WIDTH-1:0] readDataB
);

reg [31:0] registers [31:0];

// Reads are asynchronous
assign readDataA = registers[readAdrA];
assign readDataB = registers[readAdrB];

// Writes are synchronous
always @(posedge clk) begin
    if (writeEnable && (writeAdr != 0)) begin
        registers[writeAdr] <= writeData;
    end
end


endmodule