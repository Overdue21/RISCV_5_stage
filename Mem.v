module ram_single_port
#(
    parameter   ADDR_WIDTH = 16,
    parameter   DATA_WIDTH = 64
)
(
    input wire clk,
    input wire we,
    input wire [ADDR_WIDTH-1:0] adr,
    inout wire [DATA_WIDTH-1:0] data
);
    
reg [DATA_WIDTH-1:0] mem[2**ADDR_WIDTH-1:0];
reg [DATA_WIDTH-1:0] data_out;

// Tristate buffer control
assign data = (we) ? 'bz : data_out;

// Write takes precidence
always @(posedge clk) begin
    if(we == 1) begin 
        // Write data
        mem[adr] <= data;
    end
    else begin
        // Read data
        data_out <= mem[adr];
    end
end

endmodule