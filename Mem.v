module mem_dual_port
#(
    parameter   ADR_WIDTH = 16,
    parameter   DATA_WIDTH = 64
)
(
    // First port supports reads&writes, second port supports reads
    input wire clk,
    input wire we,
    input wire [ADR_WIDTH-1:0] adr1,
    input wire [DATA_WIDTH-1:0] data1w,
    input wire [ADR_WIDTH-1:0] adr2,
    output wire [DATA_WIDTH-1:0] data1r,
    output wire [DATA_WIDTH-1:0] data2r
);
    
reg [DATA_WIDTH-1:0] mem[2**ADR_WIDTH-1:0];

// Reads are asynchronous
assign data1r = mem[adr1];
assign data2r = mem[adr2];


// Writes are synchronous
always @(posedge clk) begin
    if(we == 1) begin 
        // Write data
        mem[adr1] <= data1w;
    end
end

endmodule